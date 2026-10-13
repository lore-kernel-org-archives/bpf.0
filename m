Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9303AA51E
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877571; cv=none; b=n26+RBkMeEN+bLzweim40DLF8seUSt58iHMu5SQYM/EfqM/KkGa5NOrlR6+uQiR/Cu01l7i3oQIOXPnkIovww7+ySrgSd2d5pu5QJcKl8dJuNVjUMMI8kWX4JwhIq9EQ4bSxm3gU6/896UdoUoqF/3SowIoQeMpLk8tk7T8/KLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877571; c=relaxed/simple;
	bh=xFj5cGur0Q/sI7DUo8UCS1UeyH5bKggWL1p/CrCUWkE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwbJYYvgS002UDi0J+OcXwbxEvTL3gGaD47i5ONr6Sb77vjui4ufdNH2izab9fco5y6axZ7+R7bgcmGDlCOL4aT0mgNIJAu4oz7Q82HUXtrgnwRwGL72lIiUa8UvmLMpg2J/EXaM2jiqqdFnC0lY+I0h30GktIG1ZGtB9IHfDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlBnE873; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlBnE873"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso1813643f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877568; x=1792482368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+7XHIO7zUqtURKl97NcoYCEUKppFYKctf10E9Sdr2f4=;
        b=NlBnE873MeWyxu4xKD5qvjlXzv8A9ufPR4bDAZU2M64OpIptsm5W0KB67O/UetfB+D
         0vh+kcTtKAarYkpqCq9F/1iTgv3C4gozcWre7/W4QhAhydt5qQKKBsQNkDd05J9o2vrM
         wEH8QYWPsMsIWPb6q3k3UWoW3HeGtHCNolKA5AqjtRkMgpwVpbPB9SyQxWCDL/Jr+7HV
         wtJ0IHCfWuDFTja53K8EATxg7YPSg1XEpJKySJmLIJfb+Cr71CZ/HZcspP08UtHJUtbb
         MHSmesFeeC4UdVNLWh3RPin6ep17ng+8C6upCk5s9J8KewEcDeXPxN00DlSJuIpduOsP
         Atww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877568; x=1792482368;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7XHIO7zUqtURKl97NcoYCEUKppFYKctf10E9Sdr2f4=;
        b=jKQvbBWOT6bMbVsu9iX88xcZU9z5b3gmp4tYeFuQcwKkJt+bxC7gznUun9u0uavPYj
         dIyUXr9CZAbawC2CjymeXels4/QPNDYrsfg4pZoH1694KOpo2XGMED80evmFL1VIYbe3
         itJJ6epml+FuSopbql+3h/SFT1FU6Y2BFp/KuCmXoo//eunmwT/nXNfgteplRk7nuyPn
         9vr+M97td9cTZdnAby3mgdz+CAzTwaWJLu6+eXkd8zULiNOqjc+7Djpsz+2z4qKZ/1A1
         u4W21Mcb2Fwbe/fHtzHmoum+uGG5h0Ip7ezLnqc9bdc8AYYeW77yFepRwA3acS+Nimf7
         yjbA==
X-Forwarded-Encrypted: i=1; AKwUvByWZkrWKXSYqBf+a+WItvhvoWVylYUiwZh1Oibdne/70X8YMaSK1siahEaN4PlVcqKrdMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDHiXkJbyUgpWmiElh6sNHgFfxJZ6s/dyWvlJp4ruSDgFBbjyH
	S4Iq1wwsbCU+UA+suG2UIdISG6KCBfKKwQB2hiZ/vCtMLUDsZglH6OIg
X-Gm-Gg: AYBFou3ee+dvrEI6O1jNUqth93+lf9BpVhnDTBjb7P31De/OnZFP9Yj6oySFuQr6s/y
	thXONqzn+wpER0YwXDJrmfjUgevFgPE18zz38h4ARr3wJW2ktcIcQS/l15buFpFA9CS+URtnKPp
	JlvSOdvBWGPo+LX9vnkDBvyqipjcgy3Zvr8rRKmb1osYYRfubDxRA8stcS8yK6j9vQZz6lvjY3p
	bcdlbaOl94TmnBW6hL9bnTCye7PaHdJvtH8txz05m5vgPzkWE6hMdWL7BRpe2VMB+aMKZf4i2pI
	KD9ng7ahoS/Bq5EMhrYMOU1NhIYaWN31B5+hVrN5X6Fgpe38MDum8bWb20Fu0xcSGcdaIDefFNO
	D1y97p5mu1SYZpIzfoITaRd0doClVGcAeKckpsGPephs2VXhtplVy661qPm/7ew5Q2MZSeaLsD8
	ugfGgBLU2gnbeX/SC8vhJm2rNyzDbvC7ByEbQWAYzlRJSD
X-Received: by 2002:a05:6000:43c5:20b0:487:27f6:a4df with SMTP id ffacd0b85a97d-48dbad3c1e2mr15823486f8f.47.1791877568331;
        Tue, 13 Oct 2026 00:46:08 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc85b1sm3366193f8f.54.2026.10.13.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:46:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Oct 2026 09:46:05 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
	song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
	emil@etsalapatis.com, puranjay@kernel.org, yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/3] Inline BTF followups
Message-ID: <as3hvUUPUiPTeaNM@krava>
References: <20261012140640.2932195-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012140640.2932195-1-alan.maguire@oracle.com>

On Mon, Oct 12, 2026 at 03:06:37PM +0100, Alan Maguire wrote:
> This series addresses lingering issues after BTF inline
> series landed.
> 
> Patch 1 fixes validation issue on loading BTF inline info.
> 
> Patch 2 corrects the base address calculation for BTF inline
> data in LOCSEC to use the ELF section base rather than module
> base.
> 
> Patch 3 enables BTF inline info for CI config.
> 
> Alan Maguire (3):
>   btf: Fix size/vlen validation for BTF_KIND_LOC_PARAM
>   selftests/bpf: Fix btf_inline to use .text section as base
>   selftests/bpf: Enable CONFIG_DEBUG_INFO_BTF_INLINE for CI

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  kernel/bpf/btf.c                              |  8 ++++----
>  tools/testing/selftests/bpf/config            |  1 +
>  .../selftests/bpf/prog_tests/btf_inline.c     |  5 +++--
>  tools/testing/selftests/bpf/trace_helpers.c   | 19 +++++++++++++++++++
>  tools/testing/selftests/bpf/trace_helpers.h   |  1 +
>  5 files changed, 28 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.5
> 
