Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71748CD60
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588378; cv=none; b=SDyE3BqQGNujF+aAb4p5GEl2aaexq79ybsoG0lOgwBXdq/60ylcQBg3PKht1N+z1yGZGOo24p6qZdUgwtAm9P21BrnwXmkZr9meNVH7tfYNGTk18pjiQG9bDFMJHuIZIKwyoOfiV3aJIYtxYtq33HRYTcFCpyDGd8ATlNuUm5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588378; c=relaxed/simple;
	bh=5CI6R6dFpmOF4hYXJRAlg74zqyXONwicd1yc0TYIspU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oygC8LA0hRAJNXBBrv/vF5pP0L1tHkthtkzhQF5UbYlhj/udtee6sAYSeN104PjtpuMo1SwUo55FCZR/KSdNVQqreIl8DQz2gZDMyihcMD36uoHXwploBU/HGLcFCHromQLW3yNOBaCSeY7h6l1YecVxqsoXNezP0QzOtlruOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxJRZcC0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxJRZcC0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso7638265e9.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790588375; x=1791193175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TijChMBC23NVVz3pTqjUMPvAowwen+r27tYlRsveem4=;
        b=KxJRZcC0FG+sVlGBskldfouHv5ZP7MIs+Sr3/zKBS+UHcJOE7FrvuOXa2yuy8ZrSUo
         Iqv9RkDdfhSh+iklurT6nS9a4uLEhRZ0V3rCAB3I5ueYchKuZcEUVsh3ka5lhbDF4qqu
         Xko4rMZ1aUWW6aGe1PMGrNPF/n+mA19wVNLhRIFtvZwXh4+qyIxQ8w8b/A5+mRS6J6o+
         VwvpHA1zLHXOTC+ayYIQtUtM6PMmhChJHuijV4L5aVrjqaXZ/ASClBHFk5r4BVhfSU5o
         arTf5VUAV6RRCUHaKYPC7cY6CbH6M0ay1MqO9poDygj00P8Rs7DPjDrJdoApvPwzzDNS
         YeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790588375; x=1791193175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TijChMBC23NVVz3pTqjUMPvAowwen+r27tYlRsveem4=;
        b=A1A+Om1bqe+lPBAkpo3T35kx+Zx0GSaYxV8JoQtalAciRrIDSYXXqu+yqt9WQ0MeTE
         F2fla2WFZh7XcA+RMEtKWD/HaxoMmEpYtf+svvOXEN2dJAZ0aVr/hxloZXSYAiy96TgB
         XtoAWolCBZ6uZCmikJ+Hd9iA8tfmh9d6ZFJK3b2/X3GVmkBZYWJQ0H8Wfw/zF4FlQ0kZ
         DuOkN25G0ihTO86MdsFzaFi7n54hzj7Vnihir7BkioLG/6tHOnOi/OkKmqE5jlEoS4O5
         NticS9EzWjapPEva0cMLt/TqQqxuqcafjupxoTM7TD0D8vFNb1a+xryT46T5LIxj/BQc
         GC8Q==
X-Forwarded-Encrypted: i=1; AKwUvBw8rVc8mJ7i0E5WVgZjB1X817IbbYv/7NkerVPARKOUlZHdIiS4aqYhofcUkZ9EbkemG40=@vger.kernel.org
X-Gm-Message-State: AFuF++nY6BFoTAS3xqmzHajUXXE8okEoRSqbPloSqz1cNanTCwgrMifC
	efq8flw12OVEx4mz26ugmE4fb2Cs5S4l6KsEem0PQ7WnBfiRLRLtpuax
X-Gm-Gg: AYBFou2lfl6ODi+gvjssRFf8AjsGEWDleNngJ7NsSElDNu05462hfJDderaNp9NJNBq
	z5+7+Se7vZVkqoN5e15g7LHgkCuD0dxTO23BqaRoLf/GKHS5mUltq3QoovV0sVg9ppx3hIKcoXh
	jXWOVAq85mlWO64qM1itHgFW5vS0nsEN18GYhnyvmjFaiP7HXqV/r1vQMhuAaVizN2CKN/TUXaw
	Rv2lWV2wxzus60WbtkylMHk0g0Cs3pvhp3mEpeJXZ8/j/SNRiE3SfP21pwi+PLo1s7z3RHgut2T
	LAbGQ0DgYCiUJitU4bbFuM5pC+Hj2P+IsTTu95Z0yUzDk/4/je/wUsulGh7AQ/DNL516hCoNl3s
	FsjIoYzQ2naZAigWScsagnfCzCtY95gyK14rrdsiAmyUzlbqmIaoUjG+rBgKDpt7KujA0sI5LCZ
	wzknRFEDnYRhtYgEdrjMGRT6Q6OWWw/OJfwA6srx59QKzGbMILeYCPekuvDw==
X-Received: by 2002:a05:600c:a00e:b0:49e:6865:904e with SMTP id 5b1f17b1804b1-49fe66f176dmr238626845e9.12.1790588373839;
        Mon, 28 Sep 2026 02:39:33 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f3e68sm126377125e9.9.2026.09.28.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:39:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Sep 2026 11:39:31 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
	daniel@iogearbox.net, ihor.solodrai@linux.dev,
	yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
	nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com
Subject: Re: [PATCH v3 bpf-next 0/3] BTF inline functionality followups
Message-ID: <aro109AFzQhPyC7B@krava>
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926175113.2368566-1-alan.maguire@oracle.com>

On Sat, Sep 26, 2026 at 06:51:10PM +0100, Alan Maguire wrote:
> Include additional vlen/flags verification for BTF_KIND_LOC_PARAM
> (patch 1), and add function signatures to LOCSEC entries (patch 2),
> adjusting test to cover these (patch 3).
> 
> Changes since v2 [1]
> 
> - Improved flag/vlen verification to check combinations (Alexei,
>   patch 1)
> - Simplified overrun ellipsis printing (Quentin, patch 2)

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Changes since v1 [2]
> 
> - Fixed sign to appear after const (bots, patch 2)
> - Simplified loc printing to remove vsnprintf() logic, updated
>   to retain name in json (Quentin, patch 2)
> - For oversized signature strings, append "..." (Quentin, patch 2)
> 
> [1] https://lore.kernel.org/bpf/20260925170854.1240637-1-alan.maguire@oracle.com/
> [2] https://lore.kernel.org/bpf/20260925095231.879708-1-alan.maguire@oracle.com/
> 
> Alan Maguire (3):
>   bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
>   bpftool: Update func representation to include function signature
>   selftests/bpf: Fix up bpftool btf dump test for signatures
> 
>  kernel/bpf/btf.c                              |  43 ++++++
>  tools/bpf/bpftool/btf.c                       | 123 ++++++++++++++++--
>  .../bpf/prog_tests/bpftool_btf_dump.c         |  14 +-
>  3 files changed, 165 insertions(+), 15 deletions(-)
> 
> -- 
> 2.43.5
> 
