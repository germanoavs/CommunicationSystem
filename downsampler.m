function out = downsampler(iqm, c, k)
    peak = find(max(c) == c);
    index = peak:k:length(iqm);
    out = iqm(index);
end
