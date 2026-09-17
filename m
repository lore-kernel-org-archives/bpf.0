Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336F519E16
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664666; cv=none; b=RBvKh5SBodp0GGBRi9U3h8AVGxmlnRSod6qRTvrI59Ptmf6KrpvYpyFIH7hqVg+KiQA9pZz61Ks6qvQ0oKT6J4AJajls24M9BSbaaH+lLlO7UOzOJ5vYvpbCPY0duMyusjlgaCFw8wM1SShbZLVHO34du4uoGVlwZQ2QFwuZeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664666; c=relaxed/simple;
	bh=NQWcloj+nbFeZO8NPKTYbZfeCxkiVpCyiPlzalyQgH4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=TFAYhLUwG6q5CTWvBISpzywWhj/PADMuODyM7o5WIAJ1IQHFaTV8JpB3nh8vIsr0Smq0pILKio8D7OCw8R6s4ilryketCHv9mYriHC+vu/QJd6m5bsM2r7kO8iTdnuWIA799bXXZ/DZhyzuIdOeIPE7cDjLC/oeSmOue+6+9otk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7t21GgW; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7t21GgW"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so723731a12.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664664; x=1790269464; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4JizY9SP2XHp6s2Wy9xHaS9gqEw+FcWondhVau1ra78=;
        b=S7t21GgWYr3E4HeM8TT94QjsKRA+DFCzcuMTMXirfzzXKaeoZC+QgIO3p4pJsUa6T5
         bpkNN6J1PO95tC4JE/BIbEFnVQhNUn1WjFYGC6zY4mRh95q7Z68+6ITHO4roTBUMMECe
         zDmojS6ugE5gxd1gizaE++gg8qzQwXQZ9YoZzXV5OSi0UGZUwP2PwyDPPo0HLhsFJIJL
         8F7nUmpknkn0AowSgLXerVlVBSqfEp5HtggWvX59K8gGxAYbiYoRU7fRBteT1hrZqG1H
         1sj+a5f55aFv6KGzfphBexeNFFZzFWepp6GUiemz7UGzuHNhFkpVkj40k3jyR12QOlf2
         3gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664664; x=1790269464;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JizY9SP2XHp6s2Wy9xHaS9gqEw+FcWondhVau1ra78=;
        b=JhqYxNZSWDm12FaAmkt4jh1wINljj4P9xbSubqy2cEn3CDoS+/URa/pgHtaV5HzjhB
         c6I8eAN+/2I+vX6CVOEltv/hk90pUxABoJWjzCCC5c2bV+PJLI5BF61bkt6gERsUjMJN
         WO6vbLoQGlz7WqWfw1HDsc4rUPL2fdnMM8EEwfkaP+Krwdp36K7ST6vNUWLHwAlTs44G
         YvbvgpRL3EugQ6ap5/StFJ3V4yhNnD+ySuvQUDqQUKqofa92zqRW8qiGLzaqrFWmZEc0
         inKcWYPahcKpKBozLvCMapEA4a7iYuvhLSL7MwyXCKwMmqn1h3W1QvKdN0fCFAqNQfVP
         uWjg==
X-Forwarded-Encrypted: i=1; AKwUvByLwbfg8qaGihAGN4uOcWr2XXMGAAt6sqIWUvIytZLXIj5JAdmjfTBZk84bpMi7iuTEyY4=@vger.kernel.org
X-Gm-Message-State: AFuF++lZCpUT2EohfdY9tnFLcPvXll9yzH1AfyhbdaLzIEyE2CfyECS6
	sGDXkTZteS10HzWUriG3NyszEheofus4NCDbrxk0G9LVlld9V/Qs5ldp
X-Gm-Gg: AYBFou3OsU+7y5jXpO4OvSJS4gpFEsuFegEdiyH1u2TvcrpMqOMGMROcU/P7M5y5qCQ
	LPQKAFPKFPWyyhFbtYIh69Pzm2+Pj6PppglidAkF/FntbYGrdf520EN3GdaoYAenpZyU2Mud5Ng
	HRpPlqErqRrGOWMwTrlFCx/PEepyxKvFcZeVCJyhrh+3Ljoj2MKskRJGwVNd1yW9dCXPBA2Gd34
	Br8NCRSlk7kXaP4pTMURwXXHm7pzyyzBJM3C42Th5tkwRbubmVno4jO+H+7IryP8kY05Vjy13SY
	VvxrAKK2ZrQzckywf/npglo9xdTBb3u6lJ67Cv6U0oP1swbAtsEl6+ZqTGZY2w50KATdFgz9rVC
	EYOoLLR4Zt2fTT+KNEkcqtUqyPs2AmCZshfTYPYi3xsUA5ng0z+wvDNyhTyZeYjbsSXpR3vCCvr
	KJa+SA6nXjPeLLgvAuRs96NQ1WpLV5D3xoBXeByLoRTajVGuRIAElKEZab8V2/ViWQ/kUOT/tdF
	xBA7vSVs4eChIgsJYYC/5MLnCQov9fNvdv3do9bW6Sex5SRvJ9nypf2648sUQ58uqlrQkQGB6CD
	oY2O
X-Received: by 2002:a05:6a21:113:b0:3dd:55f2:9785 with SMTP id adf61e73a8af0-3dd5f7ada67mr18804336637.26.1789664663533;
        Thu, 17 Sep 2026 10:04:23 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50c24487bsm3294479a12.12.2026.09.17.10.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:04:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 17:04:22 +0000
Message-Id: <DLHR6BTEODXE.2J7T8ZSDTAVNF@gmail.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <tangyazhou518@outlook.com>,
 <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [PATCH bpf-next 1/8] bpf: Add UHMUL and SHMUL instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>,
 <eddyz87@gmail.com>
In-Reply-To: <20260917041712.1860722-2-tangyazhou@zju.edu.cn>
References: <20260917041712.1860722-1-tangyazhou@zju.edu.cn> <20260917041712.1860722-2-tangyazhou@zju.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 12:17 PM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 732b35cc08d1..845eee536198 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -34,6 +34,16 @@
>  #define BPF_FROM_LE	BPF_TO_LE
>  #define BPF_FROM_BE	BPF_TO_BE
>
> +/*
> + * BPF_MUL variants selected by the off field.
> + * UHMUL and SHMUL are only valid for BPF_ALU64.
> + */
> +enum bpf_mul_variant {
> +	BPF_MUL_VARIANT_LO    = 0,
> +	BPF_MUL_VARIANT_UHMUL = 1,
> +	BPF_MUL_VARIANT_SHMUL = 2,
> +};

Slept on it and imo it's too verbose for uapi.
Maybe just BPF_UHMUL = 1, BPF_SHMUL = 2 ?
No need to name zero, sdiv doesn't.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 4e208cc94752..4f746973481b 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[...]

> +	ALU_MUL_X:
> +		if (OFF != BPF_MUL_VARIANT_LO)
> +			goto default_label;
> +		DST = (u32) DST * (u32)
 SRC;
> +		CONT;

The verifier already rejected these. Interpreter doesn't
need to re-validate.

pw-bot: cr
