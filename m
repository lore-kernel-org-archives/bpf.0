Received: from mail-wr2-f19.google.com (mail-wr2-f19.google.com [74.125.225.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1E33A03A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239328; cv=none; b=bQNauWHu8QvAG9BUOAJl03NUmtlKi2HMHgLnccIYEdMhO+DtysHmDOaJu509tN4cfeT617F7kQQGeYoHDjy56ddth5yEsNuh3xUaKdHP8MTqgtuTn89k9GqXQJlNlXMpiqGPZSxyOYTlI/7xeRO/J5DZ7Q6g4NhWSZxJQSLlOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239328; c=relaxed/simple;
	bh=6MaUfVqdYHmGCpRyTLZii11+rvPZDEAMCHrmMk6pE/c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0Dt5Tr3+hw2HJs7EfFaWmLuBwhWMqAsMWGKrXzNZuvsGHuOX5qQV5682FoHPKDAY4Y/3GYsdo80Q+sIKCFMbMo3SuaDWyTlqx910604oMAIuuVquH4K2Gp5x8ipel2YiaVuipCb1wnIegHd+3jftgVjmVzQL2oFQHOuIuRILMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiTwztyR; arc=none smtp.client-ip=74.125.225.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiTwztyR"
Received: by mail-wr2-f19.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so999073f8f.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790239324; x=1790844124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MIjiYoeQqempVrkvI/GQH++IGDK64N+JEcdd4PltG8A=;
        b=HiTwztyREOp8abzgpwNnOxqC1fnbIwPtNsp2sjwIw2p1PYUlGj5YF9vohPGnrRijE8
         Mo1uN4kaFjv0UGquJ1dPAKx6rd4NDVFiDEcMl3mpRoJBMidFcxB94bup/YF0wu/irvsh
         /v12EmvJ+I1uR67TQJQEsGf+EYL8rEzMmFT5CWXUG2CqhFvNnyuiGu/EUvBmCrbT7cNt
         gYBRCPSrUP2EpN8tnsXtXdaBuOyFyxZbzMHusiULD1rk7FG609rlB6jN4r0xnaUSEuBS
         IJan2i1QNK8vLC+L7Yt9tQTF2yuErpqIr9Hvp6Xlc7PcBSxl3e5Y30Zty+NhFt1wqOCK
         VPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790239324; x=1790844124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MIjiYoeQqempVrkvI/GQH++IGDK64N+JEcdd4PltG8A=;
        b=Syae87Rwmifd3heD7Q+776ThLo9AInKq25Qy0p4xGBgbu6UdgTaAmRJpvsyszwmz2c
         hfYEvjGvM4kPtiHNKpS5lWqMV2XU0B97r/KbOEvE8TNfTSsTDYGPSy/LxP1EnrlYuPMi
         A2bRxFhVTCi3SWGBPQY/7vFWrAPt1ux1H1kUUpCKDeASP5X/kzEsVicleS3NHYy0F8nq
         wRquELUc3KtlQGegqoTO4VA67CnQUR5VQKIe7U89S17rclb0OK7yuXQvjrCoxNaPaOOY
         fT5WLYHgbGuch3uXH9nYrr0JR3BkAP84DD7mxPemTozfVPt83ukroGs5C28sWUdRbGMg
         PFzA==
X-Forwarded-Encrypted: i=1; AKwUvBxm29/oXRZyjcb8tv7OTLwdalOneTxheW/DPwrVb1VHBVmObYmPqrvvXXFnqdZjs0hFmj0=@vger.kernel.org
X-Gm-Message-State: AFuF++l8snbGLBachWhPgcQTB7LFENUsC2aJpREb3t1RnUTLvlha81pQ
	wVhBKNVexO11J3sJmyCTm1Aj/f7Oy8RXkE31dJ0dOHtX4FRrRFxEqTx0
X-Gm-Gg: AYBFou3eNKddLo9eO66rn0os9qa14HJiEpxd91yElaYFzDuTNpmN+IgQ6vZb6vYUkIR
	FTW/ZEH57+6AiQkXLqsULD/ilwDkx+K4hBhfdVVPEhgdx6+Wg0moNCT9gzOlpWdH7jgFzT1+Vj8
	SXgVWzCUzk7Xq8WGHuBnxjrIhQoXdnGiqphYHdj7C36iZB4mBRj4+17lCqIQWmXoPXvsHuqbVUj
	/GhD9EMbENowKjL/TCgW4GyZrqDVaLQiObLiRHn7RpZi1YyOxXgRq30Ab8Bkj/GfLbFPKggzEZR
	6iZq12Rsq66jRAIttSrznPRtxRVW7CJggcrsSjOFDQiO1Hi4gDidQ6wMI4/v31nx4LEj/I5s2yr
	yd/2zoZ2XFM6WsjNSZbT17BumKo8tU6Zcl80IseHkK+MuY9cF7Dg7EXR5mN3om2ywAGebynZLpk
	qLovmmOSvyDc3tVOgSJXX6/j804kHM52e2qNPQlOaTMq1sQ2gqWz9mCJABFQ==
X-Received: by 2002:a05:6000:1887:b0:486:f4ae:72a2 with SMTP id ffacd0b85a97d-4887170dd0dmr2851872f8f.1.1790239324220;
        Thu, 24 Sep 2026 01:42:04 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c500sm13234470f8f.19.2026.09.24.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:42:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Sep 2026 10:42:02 +0200
To: chenyuan_fl@163.com
Cc: alexei.starovoitov@gmail.com, ast@kernel.org, leon.hwang@linux.dev,
	bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, john.fastabend@gmail.com, song@kernel.org,
	ihor.solodrai@linux.dev, Yuan Chen <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Keep target extended until its last
 freplace link detaches
Message-ID: <arTiWpZ_pWsEMQa_@krava>
References: <20260924023737.1140521-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924023737.1140521-1-chenyuan_fl@163.com>

On Thu, Sep 24, 2026 at 10:37:35AM +0800, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> is_extended is a plain boolean, but one target prog can carry several
> freplace links at the same time, one on its entry and one on a global
> subprogram.  __bpf_trampoline_unlink_prog() cleared it whenever *any*
> of them detached, so with two links on one target, detaching one of
> them re-armed the unbounded tail call loop closed by commit
> d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace"):
> a single BPF_PROG_TEST_RUN on the tail-called target then panics the
> kernel, reproduced on both bpf-next and master.
> 
> Patch 1 replaces the boolean with a count of the freplace links
> attached to each target prog, so the target stays extended until its
> last link detaches.  Patch 2 adds a selftest covering the sequence.
> 
> Changes since v1:
> 
> - freplace_link_cnt is u16 instead of u64, per Alexei's review: it is
>   bounded by BPF_MAX_SUBPROGS, which counts the entry function too, so
>   up to 256 links, one past u8, and it sits in the padding next to
>   stack_arg_sp_adjust, so bpf_prog_aux does not grow
> - dropped the separate is_extended boolean, deriving the extended state
>   from the count itself
> - renamed bpf_freplace_check_tgt_prog() to bpf_freplace_link_tgt_prog(),
>   it reserves the target on success
> - dropped the WARN_ON_ONCE() on detach, per Leon's review: the count is
>   paired by the link lifetime and the sibling prog_array_member_cnt
>   decrement is not guarded either
> 
> Yuan Chen (2):
>   bpf: Keep target extended until its last freplace link detaches
>   selftests/bpf: Verify is_extended with multiple freplace links

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  include/linux/bpf.h                           |  4 +-
>  kernel/bpf/arraymap.c                         |  2 +-
>  kernel/bpf/trampoline.c                       |  8 +-
>  .../selftests/bpf/prog_tests/tailcalls.c      | 74 +++++++++++++++++++
>  .../bpf/progs/tailcall_freplace_multi.c       | 27 +++++++
>  5 files changed, 108 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c
> 
> -- 
> 2.54.0
> 
> 
