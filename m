Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E03C0A1A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645572; cv=none; b=r3ATgZRAYARh8jxhJRGRvKqSLXBo/LZntfDjePYDt1FYqM0LbD/kqfTJxxi+MXXJniUzOffpzLWyln/517GVz1XNcQNWDCHuuqIdikzXtnBdJDHwTFgJMo4gQdwId9xWUSflNkPLCHGcHm7OB0SGZ/XQ0bfqJvj9+QiiwiixguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645572; c=relaxed/simple;
	bh=cb6Kq+qbHxqG2g4cz0qQXBCa62NEUSqGSlLVionhSME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gPspLOU9pr26P8JiRvA3EyGxDp6j10DdoH0v39ikfGmcGwTY63OhU63QwvDfXbQg3ILyb/C0RjbuW7IZyJi4rUhwKRqw05aXF/U3GwT31pQT0lpZCtnWTPoOnUktzGSmnTo7hRUvsRpN+wQI3RT2EQ9aEvbh7rVq9OYgrYS1O0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jb71+7HY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jb71+7HY"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bdb3fd39045so200365866b.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780645569; x=1781250369; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDvMNda4FA0hfv/ely2/T/n8276TkstMDfZE/QAG2ww=;
        b=Jb71+7HYHBOMjihy/Q0CEC/NMu1jlMREcsVu7oHkl60wZq/JebNNw75wNRnP+l9CbD
         kVI3CX01K5UYrgVpgGkyrZMlbPGkq8U8IkdnhbNCLMv4DeQWUXqYf/6Qxu93qqp3Eupc
         vYXl5HCKy9+zloHdwU8r0XspJH5bmfImFd6hJLcjG2d7ni1X3zTPxya7tlZPyNW2xyOc
         RmvSHhvqNAOG1uDvn7PH+SqLCfQZDMq3XYkV2/8mG55ZQkcpdY8AdlGM2kGHJlqvXWDk
         dEyniapbx9XPp5FuJagzJC2sT3Q7zt90tFiaIXodwv3dF0YZEiKlVaRy8GsxJWXw2+gd
         FOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645569; x=1781250369;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDvMNda4FA0hfv/ely2/T/n8276TkstMDfZE/QAG2ww=;
        b=ffpN4vh1EgzFebOkl6yfowakcKaAKLoAtmGhrV2tqaFskouCFN4q4qPJOyVcI9G0f/
         8wLb/60z68rA/LkiviA3t4iqzTUMNhy78hELI+J+G7A41TmrX+IdJzbDMGy7Z4mra4U5
         g/Vlxv4jH1FfgNVdrDnRqykulwfMfcpUUz5nW7+HDr7pPHy3AcQYxGK/YUwKH99dwDr+
         njWU62Cs+PA50dntX26Hwd5bpuwwUwQ7efP4GHwYLecN9fYpnxcL2w4IFmc6oJSyAKL9
         YVCPHzVQTAzZURlgxKQDvvBgK5qRR/vK1t8xUSoqCpER7Q53i/5mg/o0C19CsvF8QvwN
         jvZg==
X-Gm-Message-State: AOJu0YxnGRSfxLbsUqSDXOgTpB1jF+BjzFE3T9hnkZGSXEJwctKOJ0pC
	bSkUCz3yR1NqwGF2DVINHKh2AbFHNdrIlq19qpExy3Z0uE57d8QZnkftP42dZFeDZdC42QSBOQR
	akbbNiFc=
X-Gm-Gg: Acq92OENEy9XAxm/w/4RfDH3cgkDAPs4hQAvxAeX2F9TBc1edF0Px1DqNnNZ1QJutsD
	4TumDhAYIo7La+3G0Dlw96Ysrdi9qkwfSi0zqByh9Kne+QZFTqUTIv3SaQk1WCRTevqfa+NZLnn
	aky48KoKJ3muxKCOtWNSzpT4VFBeqZ74XRbSuTlc6GEwhBiNT+dChglsQCs2So0rZYdoyOQ4+EX
	brzpe/uJDzG7lB9iGBMSD//4eRbnvbngPWjmDRf3mz4wjV7I600h5BvZcf54JbndpKzVN31OFaH
	uxE/+AN7eBWrhbHIbBVKXqU2BK690/UQ+aCoJFtyk0XFchG/HvLsuUIT/21lyov3DQLEv+E3n4V
	JLTE7c4/gnUlmtlewkOhuxWN0eQGiPVF+ZyVL52WGb+08LatUSQrx70RoRs/O7unNUi3Be458c8
	eQRLVRIoX1KNhN6ed503H5dwQUrVdAVchsZij9V0K8Y/8154bO+uV6Bg==
X-Received: by 2002:a17:907:2673:b0:bee:1e36:8772 with SMTP id a640c23a62f3a-bf370e5be57mr71949766b.20.1780645568919;
        Fri, 05 Jun 2026 00:46:08 -0700 (PDT)
Received: from u94a (27-240-32-40.adsl.fetnet.net. [27.240.32.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c6748f9sm5359153a91.5.2026.06.05.00.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:46:07 -0700 (PDT)
Date: Fri, 5 Jun 2026 15:45:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: BPF CI for Stable
Message-ID: <aiJ2X7ut4lky47aV@u94a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Following up on the LSF/MM/BPF 2026 session "BPF in Stable Kernels, an
Update"[1]. Since the event, 6.1 coverage has also been added[2] (thanks
to Paul). With a collaborator on my side, it seem like a good time to
ask:

  Is it possible to get BPF CI for stable in its own repository under a
  GitHub organization (e.g. libbpf/stable-bpf-ci)?

Currently it lives as a personal repo that is fork of libbpf/libbpf[3].
As someone (I think it was Andrii) pointed out during the session, the
vast files currently in my fork are not needed at all. The GitHub Action
workflow only needs the .github/, plus the supplement files under ci/.

Technically BPF CI for stable can also simply be merged back to
libbpf/libbpf, but that felt less ideal because:
- kbuilder-debian container image currently doesn't work when testing
  stable kernels (I haven't look at reason of failure, might not be hard
  to fix)
- actions that tests stable kernel will be mixed with actions targeting
  libbpf itself 
- BPF CI for stable will have to contain version-specific tweaks (e.g.
  [4])

None of the above are fatal flaws that prevent libbf/libbpf to host
files that run BPF selftests on stable kernel, so I'd say having a
standalone repository is more of a personal preference.

OTOH we can also try kernel-patches/bpf-like approach and have a
kernel-patches/stable, providing proper, fully-fledged BPF CI for stable
that tests incoming patchset to stable (not sure if Daniel was asking
about this during the session). But I find this to be much more work.
The current approach of applying queued patches from stable-queue[5],
while comes with quite some delay between the moment patch is proposed
to stable mailing vs the moment said patch gets tested, seem like a
workable compromise.


Thanks,
Shung-Hsi

1: https://speakerdeck.com/shunghsiyu/bpf-in-stable-kernels-an-update
2: https://github.com/shunghsiyu/libbpf/pull/5
3: https://github.com/shunghsiyu/libbpf/
4: https://github.com/shunghsiyu/libbpf/tree/master/ci/diffs/6.1
5: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/
