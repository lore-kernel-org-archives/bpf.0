Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438356;
	b=hOEFGWM5Sp5SWMmttRMz/sojlRQ/ofxli6+OvUBw1Nj8vHIAxmBY192LwXRAx1TOejbR
	 zSaqKC+UQPdAiY4AirtmMPFY2aTl8Sy8I+YwrAxIz7PhSHv1SY1Jn0Wq/snxuZLSXKdbm
	 C93jnkk1OqvUxGlSwF2AF4B5DiAa+hXCPB7jjUvOulS+/AtACEAXn/HwJI8Irvf7DFu5U
	 u81RQZDQe5ywa2ODVlzWtDLij7Mx61KJjmRq9pSClhEX9J8VZbObXM59Lh2Gh2RX/lQJr
	 mwzN2JiVn12bDoUG/+Uh0h/YNICTvN16vSyOwHug+ZxBEggk+qQF2kaBXsBVa96CSXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=2p/b3dKU4yaXi2AGlwZNf0VKw+YL38Gm/OTwUzr2FI4=;
	b=OatySOpAVKBqSWzFTYSaZRF8TLSWbg40SdWkpyLxEOt5ftukCliDFrHFMtVO/2gzHTfi
	 SmO+jPfc+lE4u/Wf6KqVeFzDxtyPtps7oP67culhEpDsUoriMt4FnyOixapTvZHN+7L3L
	 q7MqijkzcFGB2qslsUV7TtVCBAGWp4+WkjaKNFxCDoNsiT4qldrCQUbCg+s/fGLFb32ab
	 7f2UUkyd8831LvqhzQQJ597C52nQpuYMpiTdH5oc1r+XD6GOP35pNAFn6ILKgOw8As5BE
	 +Wm7HapLdXnnMfgaN6m9rEFWu87ffV5fRgQ+bE1SastFyQpDFBspz0wQCBiFKDrwXCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6MjF+RW;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57B8606A323
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 19:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B57B8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K6MjF+RW
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e831e86ebfso11738485ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792438355; x=1793043155; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2p/b3dKU4yaXi2AGlwZNf0VKw+YL38Gm/OTwUzr2FI4=;
        b=K6MjF+RWPcaa1IuhgGzw0sG86A6QKN4jmNjfG6QqrnNuzBifkGcISdfauMh33Ulkt+
         yYec/scqdE7vQS5kwQ/3O2v0LOQ4nlB5tKmjdNwLSZp0DqKlBgoVBzj4OOgOFdp9D08s
         teCGBpIPXDqeqa1Axp5qtShJNSex0kfX1FqoF92nJLV/sMMwq3uQjnitJ6LMEQPj7KP6
         gTWQtxdZ1emayUJWwuhtWCHPFwt4cb7R2KcdSFCPMTiW4kc2EsKKdZpCUmvjQ/5xuQUz
         awj3PIbXOBLjekBBbWSjr6jztl7DBDzqSyyV7lBeL2cV4H4rgxTRY7mkW7QrnZ5seWS6
         6WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438355; x=1793043155;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2p/b3dKU4yaXi2AGlwZNf0VKw+YL38Gm/OTwUzr2FI4=;
        b=YQ+qGW9nryY/X9ttnGZtd542k3rXIwiuYYuuOiXNWqAWALHuMzJ8hRvp1ob7pL9v8T
         eSLIQ5boKLuIGLoohBdxhrqypx3df3sLKXpIW8gDJpzrX6OYWDAawSfx4X74+nQMNcqz
         Gy6abvbJRE01DF2WrJ0EeET/JZ5Nv2jPHqZ6EvDzuz1KVYAUjhHzUs3mwU25pdq6gOAu
         M9rCvrJbE93Qi+huWe8ex/XeN0VC9S5oU6yzy26HdDhtL/WMxj2G/FwisxEZm55k8wlc
         zLEwEY6Fad3dNJzcl+svyg2cYsBpvcn6sJrjInpLIKre4PGkpy4Gw20FPkkVpJTieDUt
         54xw==
X-Forwarded-Encrypted: i=1; AKwUvBxRH1TNyaBeIAKC1d9WS6LhvAzKFmm6f9Ast7JJCgxG3Pvwx2Hov4mt99HFJdzqWWm+Tbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWbb7F85cVF/BQWP53aBOXBPssdlEE2yqEL/mBQrRABYLz0Nxi
	KNvWGR8vbC/YGcCqtq7rHxOz6q0v1QsPsHODuixavT+ntQbEXXS9LBe7
X-Gm-Gg: AYBFou0o2zfExsMn/gSS527bXEidr6IRuR3OnzqI1fPUMMzsSMeROw3xjXY2qDPk+N3
	QAqupNsyQ2h24BM3oHCs2OHk8VvNelWurps6s4RUdAlUum7dQ/cCi37GNmcZfdMxNijklkcGp+c
	JumOzj7/uq+8XWKk85APe+AHxvTKYpnC16AePIUkGmGBbB4w0GZkWHZpXvtPw7JO2p0ZhbPZq75
	IjB2grkt2vTKazBLCRWPg2SNBR/O3LexNLy7M0p++RngoEC/Wo2BAMnOw12u8/cXt/3k2mndZTv
	VHfJUHckZZXXIDBMNgGiZWzaMLNxyATXCXC5/mmbFQ5FXM4+4HOJSZR6L+CmehzkVin4953/ppm
	Xqtu/d+6t8gvSeWjtHJHLmMhP8j4MKen9ru5ZvFffgqL3SIgCVI3j0FE//CJg4g21e1y3QYxdGq
	H2NziTH+Fq059nHRZhDOnn3ysPB+JsKTFxtalS1pogk7XjG3YXUKcgC8bg8QzYJKfZapuo4BAF4
	bPDUXisaxWLVR2mGe71QdFIiQ5TrBYsN7tCtdXj6M609MaF7JD7xbm7w38WzGKnLWU61lcG4QAD
	6+G0JPGyfpZblWCyupDXrxRNkTZroMeSk/AWJhqyNp5D23WtqYGhVCZn7SDzHM1VWQ28wTQUro6
	6BZbzc/w=
X-Received: by 2002:a17:902:ce83:b0:2e9:6352:6c61 with SMTP id d9443c01a7336-2e9a69f7224mr76901015ad.19.1792438354918;
        Mon, 19 Oct 2026 12:32:34 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151a2a06sm4758725ad.73.2026.10.19.12.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 12:32:34 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 19:32:33 +0000
Message-Id: <DM92D7YEU0AE.2XRZH7RV2US4@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrea Righi" <arighi@nvidia.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Josh Don" <joshdon@google.com>, "Vineeth Pillai" <vineethrp@google.com>,
 "Balbir Singh" <balbirs@nvidia.com>, "Shameer Kolothum"
 <skolothumtho@nvidia.com>, "Himadri Chhaya-Shailesh"
 <himadrics@protonmail.com>, "NchangRoy" <royfru44@gmail.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs
 files
In-Reply-To: <atXYdpDukXObjE69@gpd4>
References: <20261010224902.1232178-1-arighi@nvidia.com> <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com> <atXYdpDukXObjE69@gpd4>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 19, 2026 at 01:44 AM Andrea Righi <arighi@nvidia.com> wrote:
> That's fine for a single long-running guest, but with VMs coming and
> going the host arena would only grow (this was also Josh's concern about
> the high watermark). Would it be ok with an explicit release of an
> imported range (clear the ptes, flush, set rt_own back, unpin the
> folios)? A BPF prog touching a released range would then hit the usual
> arena fault handling, like any unallocated page.

make sense to me.
In my prototype arena_free_pages() sees the imported range in rt_own.
Instead of returning early it can do the above and
give the range back to rt.
