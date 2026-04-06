Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F238B7CD
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495954; cv=pass; b=geJSZH9UlqHITeoULmGRBEoV2AV0UIOfwTAxdq4el8UV52Yu9jpGju+FtyqxDuQ8xiEb4jBi6UDP9pu5CwaRP0PnSkA+GmLXQB8PYqPcZUsQZv4OeJRE5rdKL9j+7+KqKAiRQwKD7b//Q7jA94l9lIhbWjws5RutE+3iPQd3e+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495954; c=relaxed/simple;
	bh=qtvil6kL86Txm9qAZlpcOM1zzjgiQrUK3Iv9J3/7kkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QR7tiXM1WLXCFYctpA+fNc4D10EA02UxwvDvD2h01wwEdNFAtGEasu6FTyU2BmHtLf3yI0R4+P9phU2a9z6cMszTGZdbg0UGhGyNaAKEPdFWYeSsvPqQtwfNTaTTBuxHQ+Ztt6iGRc1rezmKttJxdXYCI8w2KcPzQiwiFvhZ3r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGuiUV0B; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGuiUV0B"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso3698691f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775495949; cv=none;
        d=google.com; s=arc-20240605;
        b=j1ikujmkDRUx8rot6fkFB8i+y+x9W5gg9FayVygpFHnnUSBzxP6Tmt4nKrissAtJQ+
         49835HXWisE9HhdZzLrHb4+0GYgrLCLQzzKPa+6qYFH3qGCA35c+EGf3jzyIrgigO5Bg
         x7ZYWpSlPSsPia88r2z00nX+dL2Zm31CI9VuT1dvQFg/B5N1sUIY1Y6hTBqHZPi1wqyo
         eVilGWoqNh8cV6bCr2oDKgCHbW/aTe5JOPVKAPQ/olNdqnpoLhdwao7fqQ/Ig3hC/sNN
         e1RCCXiQN42xEUmnHCHRfvPBY8SRfl8P3fOJqgPmXUCLxyqeOeHBGGjV3Ut07zkGvb8V
         lFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6uhFqEZzhL0xqIQAAfHr6QAyNgMw9sbu7mycq5za3w=;
        fh=DKzUNIUqUP95TGag+Q0uDky206OkL75xDe4D+E/+wGU=;
        b=ZMG4kT+UqcoCVmpTOUZX0tso0YPYjrKx4Ph+aqKn8LQrDfPyqw2rZOvPmcAADZjVwd
         8zNwNl4iYvD4LpMz+cNWlVD9azrS6h5sSIQD9OaUsfjP87kIIyD796SERUFVeEAOKRxe
         AX9nP4uU1Pof792xsrenccOU6gC6/tJn9QmZqxt3Nvx2AZHeOKsYP2d4Q0Ga3YAINEFF
         DTX4jLtH73slVMDNQcltCle8V5Yd2gdox4Ir0vYRSy6TQ45QqOswj5yO+rBR39PLTgWq
         kimbrWoTaHUOCysAPuBGzUuv/VMgGfu/AjTMzt6ps/L6d+PuNKCTuw+9FXjGB6Bz8E5H
         uWiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775495949; x=1776100749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6uhFqEZzhL0xqIQAAfHr6QAyNgMw9sbu7mycq5za3w=;
        b=rGuiUV0Baz9OubxFP8TgohDpoh6/4/lhem/HPqQoN5TNSr0MCsR7BXxYhSDNoc82Qr
         YuMhT2S4mggJzJSN9p2MtWWyLRFEp5zMddPw8KFjfQ8TQpQi0gYuJ0DqeXcVZqPSQnY9
         5mhr3HrtQZ/G+2qxxupmMUCg+VBQIPbYRFSGjOMpaoxYO1lUB2OjqxFGxN1rHor5lMAS
         8eGGi25o2EDFzw5OXo2PVM8YgJv8lm0NfClR85JCiOb3L22+q3HEXF/SSwFJwKauRnhE
         RNoVTuX8hJL+2eP2ISZBd5UqKITY0NBFQ+a38xezx2zpQGg4apVB/npaSjwMW5iViIKf
         4Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495949; x=1776100749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6uhFqEZzhL0xqIQAAfHr6QAyNgMw9sbu7mycq5za3w=;
        b=VHCy/sHJRROXGigbhJ/z59DfFh1m+yrCfU40Si6Jhkh4oF97H7fMnm+M7LlYLjErG0
         OmfFTwPB0nXNyt/8DCZbm80VPZJRXJtm8pnyAGN5QW9GAxzXhaDS9cRz8YLffEJh1QR6
         8byr/IWL+4psP03vuzXZtvIrH6kQiQsbXXeWDvM/ItNJly0NSeT7FpW2b2tmEl/4gGn0
         lfOuAdHbR9H81f5tRB3XIEnsQTbsCcLhmU/OXk3UGcIWAo/vWuDPhy95fvhUCQSyxQh7
         PYkD9sLPoRUyHOESQLXSMV/tYjG3H8ULiidOaRTei8HX++x7W3T68IwQgJttwR/OaYN5
         tRoA==
X-Gm-Message-State: AOJu0YzMXGeYNDmfAPf/WaDL9rIa+gPQ349iys5ovf/EAVO6Z6zo1eF6
	rHrOIkNXVVsfIxQ+D5HwYQpEokkDp6wDGs+AnBdjTMOOWfh3IpF7u0iC5cDrCEcUw+WMe9T2/7c
	qWJokeNziOZRPgZLtYX3pno4N3MrwlnaoSw==
X-Gm-Gg: AeBDievOnRkXDEs9m3E61KIcJjViLmIkIVudxG007ZXHdu5Ld5g1HvTuMwmn9IpLmN3
	lxtBq9nHpsFWuFCvU6vvR6jH3GsX3AX85W03po38EY+gG+kgJAV38/bNDymql0ZRz+UXhfqk+Wx
	wtU4/gB1Kwt6bQsBr2N0g3w58LIFKFNyztKYVVouuNQFNV4+TtNT2gP3LXtU8wLejtkDOXoNrNb
	SpKtdj3aMi/ZnrmAc5VRKTyfM5FZhAdwam+ZbKYocYuJvTxwsX04uMt3znL2k0ngLZyEBDxrndD
	yrNjxx2AIhH5MIs6kebGU9VgRwA68BP5JfwALfQo2ZQytBRWesvwoQALlGtp1s1TAERK0QH3q5D
	Sgw+t8iy9LsOiHQg4xI6tqiiy6w==
X-Received: by 2002:a05:6000:4201:b0:43c:f976:b8ee with SMTP id
 ffacd0b85a97d-43d292dab19mr19624138f8f.26.1775495948815; Mon, 06 Apr 2026
 10:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406165612.12115-1-adithalex29@gmail.com>
In-Reply-To: <20260406165612.12115-1-adithalex29@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Apr 2026 10:18:56 -0700
X-Gm-Features: AQROBzDkEh9IL8Ht8dRUENqyRMdgjqLy_gzec4nLOqm5yRJfK9o787_olX0PNcw
Message-ID: <CAADnVQKsmdoN_mBVVddbFuE13wZtbX0AQfO-yTxh0NVvOZMCsA@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: restrict insn_array_maps to jump tables
To: Adith-Joshua <adithalex29@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:56=E2=80=AFAM Adith-Joshua <adithalex29@gmail.com>=
 wrote:
>
> jt_from_subprog() currently iterates over all insn_array_maps
> and treats them as jump tables. However, this may include maps
> that are not actual jump tables, such as static keys or maps
> used for indirect calls.
>
> Restrict processing to BPF_MAP_TYPE_INSN_ARRAY maps with
> multiple entries, which correspond to jump tables.
>
> This improves correctness by avoiding unrelated maps during
> jump table collection while keeping the logic simple.
>
> Signed-off-by: Adith-Joshua <adithalex29@gmail.com>
> ---
>  kernel/bpf/verifier.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e3814152b52f..e2583dfd7bf2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18693,12 +18693,16 @@ static struct bpf_iarray *jt_from_subprog(struc=
t bpf_verifier_env *env,
>         int i;
>
>         for (i =3D 0; i < env->insn_array_map_cnt; i++) {
> -               /*
> -                * TODO (when needed): collect only jump tables, not stat=
ic keys
> -                * or maps for indirect calls
> -                */
>                 map =3D env->insn_array_maps[i];
>
> +               /* Only consider instruction array maps with multiple ent=
ries.
> +                * These correspond to jump tables. Skip others (e.g. sta=
tic keys,
> +                * indirect call maps).
> +                */
> +               if (map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY ||
> +                   map->max_entries <=3D 1)
> +                       continue;

I suspect you don't understand what's happening here.
Please do not look for TODOs in the kernel sources and attempt to hack them=
.

pw-bot: cr
