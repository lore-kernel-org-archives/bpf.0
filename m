Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E63DB635
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844356; cv=pass; b=Q5Lp9taXTSPoITKeTEMlMbibKJVAMoc2TyuJQ4IDg79Q9d4lLm7L6wCL2k5B/ah+xk81asQ40T7bNRsY31phjIxX5dS2nMg5YH/1NeWQtb6pbTLbJicP5C9oKsDaVljktKKxNMToahEDFXv6WV/7B3tuFOu4zs/PmCJ+54LiASk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844356; c=relaxed/simple;
	bh=i5cPT+uFJ6k3nHG66pbSMnLBQVgZ8SNtUuZYNE3FZTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPcIhy5NxD2KoOvymKxfotrdpZwYR7Ht1T7i0Kkq4S10tsM2PbDx2z/zof7XqL8nGUbS69bZRLqV0VxcEfgGqzDZLwpwDeViICMKrYBnzc1yChJmlEXRJ75CLJFA0gUFs7dmepq5M3Y/UDP6MAGqdJYrj0GkkCS3UXZfwlLIWzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTur/gDM; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTur/gDM"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c88973b6965so501227a12.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782844355; cv=none;
        d=google.com; s=arc-20260327;
        b=fw9NOU64M63OlRiuLYQPwyvp9HGdVFkeWczzIsn2aJG7S+HiLCfEyB5nBAem4J1sSU
         BWwvjIw0wTNPgg0MdY6taam13M8a6P5P7clkYaQY7P9MW9Wxbj5YyuItztCFnx7Ps2S/
         emTj4r4YH9jbzVd+mebkEGIUY11X2S0/SgFjJ4FpMeELp3MlEUqZUG59qme2RxEfqOIU
         +5o0z7RDSZOf2sa5cnivgl8u3NleScO0bTNZ67FSUDwXiq5nG4vk7Ke4t2MFtnrAlNel
         gtn9dqJZ7A+9OvXKeNep676DUnEeB0fCbPR9DToXf7qac7iwg+55ZldwJsr58kU7dk6J
         qeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3FAamP2gRA2cCM2zM3ZYVzoEGplljt19iJI6CljgOk=;
        fh=EiqklGnZCUZeRq7AR+Ugfz4FIdqRPmHfG8nA9Y2Ye84=;
        b=KFXMKpVsiVQQE5sJarLYya60iiZjFwCPfrCvn3sBBrH5fN4+WBujwS5KpUhQ9sVEwA
         /Sh1nsnz6/AygZwtoIw8ZitVN/2sbZPDE2XLJoq72PmZw4daHozw2MbRq1npq8v6Qp9D
         co4wjhvBSFYb2/F9AdwjAChBd95R02xLPPzNJMCWjbzXCrcf8csIuFnuLIyeid/LFHzg
         b0Lsq+D44qXddRkT4OEedi8PbFAlm8fRGcFnEC8cAJTzPOEApPh/SIu7D//yAGLHaQbm
         0sM1kDFcwT5SxMDrg2NnGurBlpTr0ff2myNayt8bBM2gTspcOoVRQAcce1n7keeu25i5
         Y7Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844355; x=1783449155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3FAamP2gRA2cCM2zM3ZYVzoEGplljt19iJI6CljgOk=;
        b=bTur/gDM3AjWfen2aDsFn7/hVq25cYwmJglaGBARoHIT27OwYMRERKcMril0W79H+G
         0KmwxR49WAU+DaTh45zzjGSO6BKSXE+Kme30stim39kWjQpk0ETuVSS0N3S/NnF5xIZm
         sPbc39WcqKu+z+nIv/XyScf3OUnGOFRn2iSdtFP7hsgS910iHhlqcBb9LREaIUHIXJ6I
         FQVHPVCJcmIp7M5iP4EoVBjdEkNJajBkb7K7DrRDShVlfFj3MXF9rXyh893ZpLtKzch9
         dgYCMVBrGTVePf1L32qqXgrPZdHvdJNkGjpmH+AoxBnsGHKnnclu1DmIYRh1NO33hUGv
         pebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844355; x=1783449155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3FAamP2gRA2cCM2zM3ZYVzoEGplljt19iJI6CljgOk=;
        b=MA+Y2VWins0YJlgs7ZYWhIViefyJ5vjqa0/YewraRTmctzG0PN+vemp77Vpr15eJpZ
         fY1C+WAnbVjCKOTuIot6f/YTtzoFC/phXhVMi+SvPx50R4N0ctYxh+dFuhn5/Osub6DD
         crYE/UdnT3sIH2+28EmoUG/7VJf3tL8crg2fOkWL83vRCpwMGjEF1zAB6dL9uDotH7Nw
         92E2c71dcGB9WrjibpFEXhMK6GBJON60+BQB2hf/5MF+NbSF26EFYe6IJeQYKSA32GT9
         i2P8IP7kcxsN15HM7Akh5kJIXT3ouecGM4Rk71/e6vN5buQk08eMMgqXYaXsJRQnFljR
         aBwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9OpaBfGg+q5AsqB/GrNEq6RsDkwL3mp12ShUvJiNV9dmCJtc1+6T2L+/puoAyPqJSx+ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1H/iTMsl1soA19oVWFITYWqmB46Evwmu+wvbqMb7WjUwZhv1
	YK3wrEgVXLhyu2x8OQy31LalDIwIAc97gvOLTL9g66NDVt7XiUVAh5+rn4G4Z0aAtzfEiZGC8Xm
	m8/KQ5cyBLSN10DOwdRGNQyQa/xS99Qg=
X-Gm-Gg: AfdE7clUpeLLjWEyW0uIgh+q3ooY0Ida2VdgP/1j6IS/CNQsWn5WJ0f80iIpBWm6HBV
	wsDNmMFzxEonU1QNgCS4CWayayCkpNY6Ik/mw6oPcxFmiFMQ0C50fsRPVxwr3LDZ5sJ9iruyT7g
	cMUJtVNf+OvEu4iSLaMT/sUA86pcl6oBzyXm9L/AcO5bm1QdQkujottR4UjdzOIRLQ9MhU2dRA0
	dOtsuJaB7XTr5OJT226M4NZBiqhZKpZfVNNwtqTd8Qrxc0xFOCD9MJ6gpoL175KaR1dEAnri75R
	Sl2aH1Sk+roDVZzduT7wWsvNZHfBwNZgHgh3VggWbhqbep7Y69DaFddAGA4pcPPN08M/tg==
X-Received: by 2002:a05:6a21:2e14:b0:3bf:6763:f0d0 with SMTP id
 adf61e73a8af0-3bfd2637e25mr2423789637.4.1782844354664; Tue, 30 Jun 2026
 11:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624204946.2901178-1-andrii@kernel.org> <178248062788.457674.6865742035078097472.git-patchwork-notify@kernel.org>
In-Reply-To: <178248062788.457674.6865742035078097472.git-patchwork-notify@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jun 2026 11:32:19 -0700
X-Gm-Features: AVVi8CcH4ADHKMGLKtxIIqCUc9RGZeIiph6llLtnTXNhaFFLnt2B9qIbhZYSB-k
Message-ID: <CAEf4BzbUEi4zZxEBggHzbYRaSMtQ6wWJSjHhqfvE-omvGadApw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix -Wformat warnings from
 format/argument type mismatches
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 6:30=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Alexei Starovoitov <ast@kernel.org>:
>
> On Wed, 24 Jun 2026 13:49:46 -0700 you wrote:
> > Building libbpf with -Wall (as happens via bpftool's bootstrap build)
> > surfaces ~120 -Wformat warnings where pr_warn/pr_debug format specifier=
s
> > don't match their argument types: %d for __u32/Elf64_Word, %u for signe=
d
> > ints, %zd for size_t, %ld for unsigned long, and %x/%lx/%llx applied to
> > signed values.
> >
> > Match each specifier to its argument's type where a correctly-signed
> > specifier exists (%d<->%u, %ld->%lu, %zd->%zu). For hex conversions,
> > which have no signed form, cast the argument instead (%x->(unsigned),
> > %lx->(unsigned long), %llx->(unsigned long long)). No functional change=
.
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next] libbpf: fix -Wformat warnings from format/argument type mi=
smatches
>     https://git.kernel.org/bpf/bpf-next/c/df3153758ddb
>

Quentin,

I synced these changes to libbpf's Github mirror. Can you please
update bpftool mirror's libbpf reference to include this change, so
that I can fix these noisy warnings for wprof? Thanks!

> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
