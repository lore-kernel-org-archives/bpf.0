Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C0497384
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014234; cv=none; b=BtSrCiU/JfoL26ZX8lfXNdGQsKb/w1E+PlbFeMukffdQDov96vbB8iCouUBhzoipFVGXZs5zwCtlBdDr2yhcHxrhfrwTmGGC14kSYpTk5MjOfNW2wGxAAgTvoq/C5osAeE1DW63VIgw8d1pRpVR6gCwRlIuQb/wajhR0XE6nxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014234; c=relaxed/simple;
	bh=EtI4ggX6siZdDxX9QVbhUXdUUm5AbMI5AMTmaI9v0aE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUDL8aqcdqkQaLook0q/vkFrmY28WgPvVBNoY4vURhHceX4ewX6h5lJZ4AO/zjXnjJCpdq8m6bCmeTKOfRlJIrEB+FiizFbaTnrrKze7umYDB0IxHiAN8zlCJUiUP6btvd+iyntia2SKLEBWy1jHRmtoIxYrqCcMzzDll+IXPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcOmMhs5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcOmMhs5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b001cd92bso538440f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014231; x=1792619031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8tvaxXme3A+GDB6mr5zX35hOYWPVi2nagWE6JeKbsfg=;
        b=GcOmMhs5w4i7JvGV6NVgmD99o62uNFPFKbnY3cxij55UKVRb3igVj9Z0wpJpDUQya8
         csg8cJRJ9zGgHChl+8ssUEa6AiVVOTQRkeIyiOl2iXel95aApeq9BCWKtIUtnX1ywGSy
         5FS3Sx2prEye6NwGo32GBgO4ZL2H3ApJOdXz1g4RlcV3tuPbfoSuZX90XhZnliJYBsF9
         cRStg173NunbpLtSm1KsIkDvbNaRrTpLcrwZNVrIn+SrAq50CP9Y9bLOtpyTlI/0FY/5
         qI0ltlP91IT0rP/65aVLV3z6dxlDz3H9EmFrC7FsDmqwwiBqIWtXdywq4SEyfd8zSN2l
         MSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014231; x=1792619031;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tvaxXme3A+GDB6mr5zX35hOYWPVi2nagWE6JeKbsfg=;
        b=Kzu542yAacO88Yawik+2dB9j4DldzOwyGLaKGjFIqdYtnlKY5kGA1KJA39E67fY/3W
         U5f77DuW6g3LEAtn/sddjPyTltsFARY5j9C3ifoNw5RF9t0oNzLx7lArrPt21Bo8Z2Yi
         W9xmNQOFVkJEz9J0uoEN8EVHC/HqKnOwpOxF4JMKdy1CM820IOWPJ2han+eGaWXM03x2
         d7AGlIsa1K1KCY47p5LVi75U9xOWpTLlAmTNvnSLosWYlyDrlk4SD9ne480TVzUUPcKJ
         WvgiIMwgNOvOrv/HIf3yWK4n3/MC4MatH/MaWt3QVJablMllxflrkkvsxpYoTbEvsP71
         8Wsg==
X-Gm-Message-State: AFq9FYJPpanK9X5dDbx5wXO+dLNPjfb2HK3Gglb7AtnhfshggNktyQ7M
	QYeJ9nC5EgKt7SWYMg020Xo7VPHvlXLhNSFpL4wm3rf3BBbhbiKjxfWc6jJmdw==
X-Gm-Gg: AYBFou0s2MVo0OzhSSJy5FXB46MkTERz1l/D/sy/djN13KXIxXzjYa8a71SSD7JDcxo
	etQw5c3jOd1O+SRcnmztWwxLnmLU5oRvbFeVIq3HnrusRHC0l+xSaYvbqkJ8LXRjr2JEYMJAm+S
	D55ymZtiyJU0psEk3c2vc9T52LHJu79LZxDjtLqVuPXE8fuo99kCCUhK5RDY41TL4dmhkEW3ajv
	GH3AjHrroGe8+UcUrbVyb2WW68/hflRj3UygbKMYKpMWLJ4BCH49gwlXZtJpp5L1k16A3V4A66V
	sbUZtevThLbbQ0+fOV9hD+VTEF72ONm6M0vwWdze3Q0A8h2x0ZkyxYQH4gHx7KPCQGkSlpblMGO
	XLc+Qpx5IYwCYzh64z9eGcBdQMqt4QzIN6592ZHf/LkNIcWm2UE4OjPrgldOTA7vo2Uxj8/mKqD
	ZsHHY0s7iHYmp7rSoS1lv5g+2WwFC5+OnFV4kjX3mCfBOsD0/6imYWa5URhw==
X-Received: by 2002:a05:6000:2686:b0:48d:f3f8:f910 with SMTP id ffacd0b85a97d-48df3f8f995mr500636f8f.34.1792014231493;
        Wed, 14 Oct 2026 14:43:51 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df2619703sm1681492f8f.24.2026.10.14.14.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:43:51 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Oct 2026 23:43:48 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 14/21] bpf: Add tracing_multi link info
 support for bpf progs
Message-ID: <as_3lHuqBSVQMiB5@krava>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-15-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-15-leon.hwang@linux.dev>

On Mon, Oct 12, 2026 at 11:40:16PM +0800, Leon Hwang wrote:
> Show bpf prog info in the link info.
> 
> $ bpftool link
> 9: tracing_multi  prog 25
> 	attach_type trace_fsession_multi  btf_obj_id 1  count 2
> 	prog_id          func_btf_id      addr             cookie           func [module]
> 	21               4                ffffffffc080064c 16706819         target_1 [bpf]
> 	22               5                ffffffffc08006d4 16706819         target_2 [bpf]
> 	pids test_progs(98)
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/uapi/linux/bpf.h       |  7 +++-
>  kernel/trace/bpf_trace.c       | 26 ++++++++++----
>  tools/bpf/bpftool/link.c       | 63 +++++++++++++++++++++++++++-------

I think you should split the bpftool change into separate patch

jirka
