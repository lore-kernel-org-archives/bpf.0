Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC121ADC7
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199737; cv=none; b=MBldewo+AgNHpjZKUPiWgL3+0l9PnlmXHIDdNZQVEjwUaLvlieeZcbllzsfqIdx2ZeDvNehu+i6F0BPqNjQWF/r3pwypn4pOxnufgzG2rr/qwkF5sEetN8cwh60xluU30sdaInW1uSxLwqwAKR2nfo7O7TR3vrrxo5dC8ugtmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199737; c=relaxed/simple;
	bh=Y+LoYAP9VjQ1WH+0mTFVX5LCQoQHjHxfT6/71MrLKcg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Co7u5xcRwlQ6KvhD8jZnNB3SAOY6QsYzEfZcoGqB9Ky2i8Fh1os83QDhDQFotfRuWouK75QlWfXtWD4chUrKue4QChzeEiviBj8rE8CTvk/x9j/0E6ACkoj40Bc3GqIj36GfbdQUXG/cdI06yM30grnfSjJhWx5rzIukNnUF2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ONXPA+y0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ONXPA+y0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3811f512167so3096085a91.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785199734; x=1785804534; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+wAfON367N7TUqFRglbZOr6w2el4iYP2m0VE4AXYueY=;
        b=ONXPA+y02wjistWHpL/ovBtxW21OARyei/SrNNIlUnXYIT8Dlgrl4mNX8qBlDePlnA
         I1YFOhuCAqFagnqbFgQrHNa/kTB/VMFMBIQ1bodDebJrDvL8oSoTQmqMZnDRA0j1gCDY
         DPgpUb0bXMuDct8mq0H5PHDU73hohf9ttC4vMIHGF502M77R1vgbizGJ6I60LuZszS3z
         WwqNPE0yDQlEeuq9lz+cvuTD0IpcpOXttDMqV8v4PKEnnQCLaPDQMQzntEoZuMebSWpk
         DIxjsifH4J2bcixZrHk5vAxqwQhmVni09Idfer3RyOnhOsrUX1b/QLS8yv7p2x+ktgyO
         LMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199734; x=1785804534;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+wAfON367N7TUqFRglbZOr6w2el4iYP2m0VE4AXYueY=;
        b=ZfzbwC34eP10A3xOtlvRsGyaAeiMdeeKk/88nMD4jxRQMCDL0G4WxFedn5y8qTvi7N
         CvPDPu5ctQDqaUISgbOwfW+e7F7AVn82IuTNcSQxM2Ak0gE9U5npb6DNo0kyrKTsiOsl
         ehL7PV+G/HKm4oeTPBbd75Mnt5omfCGoJRmdpoYtqaNZMf7NCGahPrvO493elk9aDbpy
         0UK+Z8INj04okcOd6bgLYYFxOJCAhG1qotGT4w33ARK8aiZthBxjRng1czN7X667VkQU
         iBMRWXb51tl12fpTGBmTNTfFmugMVO5ulDCYwTGLQjn5VPnfqdWwC7E9gBySKvGtkv3L
         YoxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIimTIIB6SCmLZ8fx+kKzVupDngpK8cYj5GFkYgomFXuur7g1NTHeGnorgZnILpbs1FEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcfZhnbkicoFSIrOT5ras1sVmz20+e8zORn2YTZDB7fEGupLU
	ByW2JwWDN/ViZgXPVxHg0MExoLlIuNCOq8MfYvM6jjcRD2dFXnFnJhM8VF6RMuaEab8=
X-Gm-Gg: AR+sD11ZU2AroBp0FraXfb7QiaHQKIdhngpZVoYxrVhcNg0fPGrac7BpGvmJlX+GIkb
	LjyAkrqAUoXo0Zf9GZzoLjIsAaUx3w+hPM1FQ/B6xOCRUv1vs27CLOnWT228yijkkN/6XGnkyFM
	yDOKKaWKyBwCK3Yb26stl7RcmlSXwrNqYYTyfJeT/D65Q461thyXoMxjuwhC+nd3hO6hdEBigtH
	nJmwhLh3gZmQ+3dOhWx+pN/QoESZvPM6vXObNZqS0fapfs8WbT7cCDzTQP3cmS+Ze4sIimFE4fT
	QLhMc1sDVPEVWfDJv1wdX1Yq3GdeP/Wxp3kwEvsCl2ElAj5rMBysLiFea4QC/bs/J4us4O+jplY
	QDIkN6hkrIjrR8HM5+13EDafsSRYbgB2MboYVUGd2NqGrL1cyl6eJ2wvGZRihU1wF7vL3Gyle7+
	1ctQz4kSPtlwlme6tlC4KRFw39DFXpPMPkFdDgoTSEJg==
X-Received: by 2002:a17:90a:d888:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38f6a30d87emr171911a91.2.1785199733829;
        Mon, 27 Jul 2026 17:48:53 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6414705bsm478503a91.15.2026.07.27.17.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 17:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 20:48:51 -0400
Message-Id: <DK9SHN2RV21T.485J38W373WQ@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add a sleepable page allocator for
 map memory
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260727062521.376231-2-jiayuan.chen@linux.dev>

On Mon Jul 27, 2026 at 2:24 AM EDT, Jiayuan Chen wrote:
> bpf_map_alloc_pages() picks the allocator via can_alloc_pages(), a
> conservative guess for BPF program context that is always false under
> PREEMPT_RT. So even a caller that really is sleepable gets the
> non-blocking allocator, which never reclaims and never engages the OOM
> machinery.
>
> Add bpf_map_alloc_page_sleepable() for callers that know they are
> sleepable. The next patch uses it from the arena page fault handler.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/bpf.h  |  1 +
>  kernel/bpf/syscall.c | 21 +++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d9542127dfdf..9ba03622709b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2779,6 +2779,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)=
;
> =20
>  int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  			unsigned long nr_pages, struct page **page_array);
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map, int=
 nid);
>  #ifdef CONFIG_MEMCG
>  void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **=
old_memcg,
>  			 struct mem_cgroup **new_memcg);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d..cec88450e4ce 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -602,15 +602,14 @@ static bool can_alloc_pages(void)
>  		!IS_ENABLED(CONFIG_PREEMPT_RT);
>  }
> =20
> +#define BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NO=
WARN)
> +
>  static struct page *__bpf_alloc_page(int nid)
>  {
>  	if (!can_alloc_pages())
>  		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
> =20
> -	return alloc_pages_node(nid,
> -				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
> -				| __GFP_NOWARN,
> -				0);
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
>  }
> =20
>  int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
> @@ -636,6 +635,20 @@ int bpf_map_alloc_pages(const struct bpf_map *map, i=
nt nid,
>  	return ret;
>  }
> =20
> +/*
> + * For callers that know they run in a sleepable context, e.g. a user pa=
ge
> + * fault handler. can_alloc_pages() is a conservative guess made for BPF
> + * program context - notably it is always false on PREEMPT_RT - so going
> + * through bpf_map_alloc_pages() there would needlessly pick the
> + * non-blocking allocator, which never reclaims and never engages the OO=
M
> + * machinery.
> + */
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map, int=
 nid)
> +{
> +	might_sleep();
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);
> +}
> +
> =20
>  static int btf_field_cmp(const void *a, const void *b)
>  {

