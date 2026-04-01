Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CD223DCE
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056935; cv=pass; b=WMjvtigPSwez+vZ2O6qg17ZbfqPu65YE3WwVyRCZ3hagQjKiEqIOXqiVcKfcOOhBy3kfuJAHtSjD6bfW/0K6o/Dt7uY7I0/LRd579f9V3h4BGpt+Tnqyks7rhHr1YA4Sjz/T55LSv7Da4Syd9dkcdc0/SGmwZ//C6iVQN51miTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056935; c=relaxed/simple;
	bh=W2B0Cd0nN7OPCaOMNRDF5rsa9sQTCM9A2OmkzZo/v1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZ4rI+PBqE8XIKOoT+Br85f+0xeeCCc+aoiWOrvkKHRf9IRb0EHHc+iga5Q7gRGc+CYpo/A/bYbVX6ynYmQLp/XKaj1CZXClkIj88vSd4PcPglg/FB6+tubmazAYJsVskMpsJ6674G7+bwAGQ2BVfUa23J8vvqTkrZ8hnyjTXxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSeH9Duq; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSeH9Duq"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-486ff201041so69617125e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775056932; cv=none;
        d=google.com; s=arc-20240605;
        b=OKDjZFnaOFzXmIpaGkIxhCcwJ2XlwEzrikU5RNXti/UHSBK3pohnkr3bTsM7MaQXbI
         +t7DMh5E//4MFM1oLuMzp9wEt64DXmoPSJG3AfQjSBaC06lzBWQVXZX1w099ML1N8BJE
         Xm/zP2a9x6uMKgNKvyWnH7lrH9jILY8/zK1M7w7u0FON5102hThk8CRcVaL1b2lJOIKt
         vnHvXr2AA/ilPSL0mo8uwjOl3JQDWqdmyXKkVzoBG7en7PpaucH4jftvubs/XVt9munk
         p6KddYLky2aRV+3D4ZUxseRu13t6d0zicM2Dn+LVaeELu5Z5ilWuDV5KvUch7Y03ze5Y
         LWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W2B0Cd0nN7OPCaOMNRDF5rsa9sQTCM9A2OmkzZo/v1I=;
        fh=qqv4dVk/6fgOZLiBoXqlNfpz0ftqMW1QU8bcbRd7o84=;
        b=TL/WSgmyRQLYMfN+6qleHeCpsVV0U3CUlLw6xSNaV8W2Pt7GbcSyRRKsex6956UEM+
         rB8NP9w4MEPLIVEW0ayOVRFCynqRxkwvtFI8PwxcEMr/So2+7K3FyuGUzWeKfea2ya4Z
         aubdStjeXB5+FhsnlKZdFbcDagDwOtCUHB+jFPR+3IIF3bkmdME9319ihtCsH84QcLEi
         03zbHmyaD6esiSaKvxy7TwBMHgOgiEbZ/3+ps2UY/CYinB4JDvbuhtbK1bdXflcMu4wN
         GUcZFJhXtJwhMapeBr9JZEPbhlzGgfUtgJKqb30UotStBJrzJJYlXFCu40hBUAd8k4u1
         KmBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775056932; x=1775661732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W2B0Cd0nN7OPCaOMNRDF5rsa9sQTCM9A2OmkzZo/v1I=;
        b=lSeH9DuqlgNmNJd/XEyAMs4kqd6auLzCeBQzLRRgZGnBdUiMLJzfWlufimJsm+3YVd
         YmxCVGjb/BezYXYpmMBK5gwltFMYIJ/2/NvTOjDq8iyHPAb1TvDlTiOVtNNfZASt6W9K
         568k6DiiD3jn+qAFF+RDIL77TEfVzNLGEr95q8DKy0Jk1ZFoJ7J82sNiszXEqKzQcXaI
         AxFNqYTWsIoCwIwOrR1FLdYkgFLIi/INdJly7RE7VXMSFDJ6AEVXsJSzIIFTwCjbtHkC
         c8BUT1Ls79jMMf9KRn0SwgLBYjmcfD3lPLDBgfA4NpgCuCSHlawrZJvI/eTFRWtuUEx2
         ImAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056932; x=1775661732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2B0Cd0nN7OPCaOMNRDF5rsa9sQTCM9A2OmkzZo/v1I=;
        b=pkJ7C60AxIN6G0WsS9gxeXodrMmi0Fmv3GeBCwRBNHTC+PFM0BxUFREcNTzWLeNZXH
         u89j/T3XnYIrtaQofse3hht3PIvENtz4sF2n5+s1mcXlOzny782pFgQD6I1i2NUOgd/Y
         NtN17W2QiuHIUuCHGNKW+h7WiTsyzr0tKOLHO/pHrc+U8DQ2t2n+l2uUs0obr6sILcpa
         HWRapTbSV+6ALKcTOTd5ESgB5HFQLo3+QgJE/jrihVnkHOnBRWsPoABIJgJYaXqozkll
         FHMe1ihZDaGbdghMAHtrfmCOJ10+u48VWp5AaejD3F5ufNSVZdNfeZuYPpTL36p7h0/3
         Hf4Q==
X-Gm-Message-State: AOJu0YxQMcOA546kMF8qBbV1FsQaAJpQviENTcayGqUeEtWMEOo3Pkem
	DPx73jnzuMpfHnDREUyDeTrlxcDn2c5epHARMnvX2f4c487/2XQN91WlPeRDSXbuGz6qrUv1l3c
	QNGl0jMGNwzIxITHmUbZO5zq5oNq2AtI=
X-Gm-Gg: ATEYQzyW4hGwluRQMKuvmym8VRU922VJt6HRgPeTCDqQNWtPLUvInrm9pHdj4HKV9uM
	KXkNehLtYn0ODa/IdY7z3CDM1QV7CnhFC+aEwecu8o4BZowO0JcKmFQrGoHiWWQCqdiGu43vrOS
	aFPBJc/reheYdx0BXiPOfWtp+wGl2HMa+G7Zx16i+BJG5gKAab0bo5wnVZlRe+vbbIVwaUBU2GD
	XLbayp0vdZi3m/yy+e9vZJrojDiFYvMlTdy7bhTusldLILY0/rPty2w/yIgY5cTnWFN3GtGPJe/
	3F3rhtopa7+C1Edo0tgTNJJf4+uCx4nT45ftLIrR4QL+f8JMLzQkWwPt4zQ=
X-Received: by 2002:a05:600c:19d0:b0:485:3ff1:d5c5 with SMTP id
 5b1f17b1804b1-488835629ffmr68533685e9.7.1775056932121; Wed, 01 Apr 2026
 08:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
In-Reply-To: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 17:21:35 +0200
X-Gm-Features: AQROBzDa_33LZRSXCVwlULMin4SmE6TrJmE6bCGjhf8DCN1NiewNDG3moj4f_7g
Message-ID: <CAP01T74g_=jSJTNzS41VzK81n3kwkM8EOY=Xv=t0yM5b1-+Z4w@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf: Fix torn writes in non-prealloc htab with BPF_F_LOCK
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Aaron Esau <aaron1esau@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 15:51, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> A torn write issue was reported in htab_map_update_elem() with
> BPF_F_LOCK on hash maps. The BPF_F_LOCK fast path performs
> a lockless lookup and copies the value under the element's embedded
> spin_lock. A concurrent delete can free the element via
> bpf_mem_cache_free(), which allows immediate reuse. When
> alloc_htab_elem() recycles the same memory, it writes the value with
> plain copy_map_value() without taking the spin_lock, racing with the
> stale lock holder and producing torn writes.
>
> Patch 1 fixes alloc_htab_elem() to use copy_map_value_locked() when
> BPF_F_LOCK is set.
>
> Patch 2 adds a selftest that reliably detects the torn writes on an
> unpatched kernel.
>
> Reported-by: Aaron Esau <aaron1esau@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

The fix looks correct, but I think the test needs more work.

After reverting the test, it continues to pass for me the majority of
the times, so it's not deterministic. If a fix is made in the kernel,
it is essentially best-effort, so we cannot be confident whether
trials that didn't produce a fault were due to our inability to
reproduce the race or because the fix was correct.

To be fair, I am not sure we can construct a deterministic test
without controlling thread schedules, so it might not be worth it and
we can continue with the best-effort test you have. It definitely has
some value, since I don't observe any failures on repeated runs but
can observe some without the fix.

One way I considered strengthening the current test is to pin threads
to two CPUs. One thread will constantly lookup and verify that all
bytes are the same. This will use BPF_F_LOCK, ensuring serialization.
On the other CPU we constantly do delete + update with BPF_F_LOCK, and
keep changing the byte sequence we update. So aaaa -> bbbb -> cccc,
etc. Set max_entries = 1 so that we ensure the same element keeps
getting recycled constantly. I didn't try this but it might improve
the chances of success, esp. if the map value is big, such that the
window of reading and writing on either side can be long. We might
also want to do repeat = 1000 or more and then handle this sequence
copy in a tight loop inside the kernel in the program itself. This
ensures that precious time on either side is not lost bouncing back
and forth from user space to the kernel due to bpf_prog_test_run().

Thoughts?

> [...]
>
