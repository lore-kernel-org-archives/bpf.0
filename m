Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516400;
	b=CcYsV4tm2p6Nifp2vaHbNQB3Ito1wJG43K9C1W1jldtq+ewUF7IlTl1szSgQ4vEG5CZ8
	 frexTnsxgc8RLoaYnKzvjlenM/GZ3Oq3DFTCIR6CsQZO4VZQZApjUPsckmVJ60IlCSaRz
	 hCVLmn9RTkYeIaynip9iUtZQ/RG1GpMqAiaK5mg2/hJbrXiNuMGOL6WbRrh5iDZ4C84/T
	 u/9MyqSIIP+Ec4p/HOYaNr757uKFZMd4/R78qbv03zd0fFeN4xG+GXMaXovlbpT7csBwP
	 Bodg5Jw7CBYspyJ5JklM6FV1zda9ISjQYmvohAo484EscqVz4zdDdH5PJAq1yS6YWlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=hz5GQHqAenEtUeQQFEsz4kxYnKJ4ExEV68tpoBxSRrI=;
	b=4zwp4rM81lFXiC6GYnac/+4fWC3fv+soKNRpXY3z/MFM7CDupkQqRm0Oan1W1S3Fmcni
	 AA3yABwgG+nOM8ycMkqn3dzZ6g6C2r5G4bsSfhqczoWLbLG6p628nduZIHEgEBivVqnhJ
	 TlkHGhw4CvBv2ALMHRMeyhU/VY3zX4wgK4Z8yvtQuLO4fsilAISDxWbxh3YK3K/bUSVuj
	 rgQSUIDiIxA/eK9jgArMbQrxZ0eElJ5T82AYwHW13tYc3q+Z6iFq9ZFjiw+G+QooZ5uVR
	 A+EevIjN41moYEsGmSxQL8LXZterBqitHdAwMdGzx4CbPhdl55kUn+y3PMdoohB97Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mFRzgcm9;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838C606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B838C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mFRzgcm9
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso134671a12.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794516399; x=1795121199; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hz5GQHqAenEtUeQQFEsz4kxYnKJ4ExEV68tpoBxSRrI=;
        b=mFRzgcm9gmxgGhSCXeOWWlMZxh6O/oOrWZWbR1v+FQMQKnRRf1UHRUyyi0iTJgwD2w
         YcW5jNL9bQLiND4CesLayd/jcdXBv/bzM2Qsh+mYd1T9p3ofQLgd+2l7TjVRuUmSmw+/
         ISf2z21yExELgwU2cOW7LAlXjDBMA7+Kp8i2LhmwzHZs2FcleOz4G0XPUycErEwreF7s
         TYcm9cYzhHzNI40XnUBoK1u0xgq1jU6RabxjObVFROzWGpVOmZleytrXwNzqLZGs6KQM
         NlknNzW+At0SLkdEX0qvlBbELp5LtnoOTpD4nUeaMfpTQvtbjpgwcc3i/ChWejExIIHO
         tF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516399; x=1795121199;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hz5GQHqAenEtUeQQFEsz4kxYnKJ4ExEV68tpoBxSRrI=;
        b=bZahM8ZhFJdhKM9Ufutfm7PM+kwuqDmcdUDldfRGz3N2RCU/Zeqxh8SgJP4aEZVOhs
         703oug1ZvNs9t5/dEh1RkAyXXfL0B+GmJWy0P50hAOjrTJsslE1tVScpTWnfZYSUfNn1
         G/WM5d2KIB50VeQ9pxKNSmW8XFNpI9fz5ODsUF5wz3WY+sxEusr8iUduEEBzChOGZq+x
         GXh31ttI1R49m0d0al7bfy0Mpdfqnr+gyBbqDA5r+eACNI3jhzkLKlPTOQDZn49gxE6D
         qCvNBZaNIk1JG1xP7ts4fPoS41/3+BSsPITprTGeq+Paq4rzUV5i9C/i3lfaaIFBiQNX
         hI3w==
X-Forwarded-Encrypted: i=1; AL+hErEY9kt9gt7Io7AAIEf4zpfM9QH0SSYz4QOUWxONL71ndzyyS9mGhGUYA8X/I5g87WUMCYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/T8kc1zM3ypzyZWth2Jnzkp22HGbruQ8oYOXK+yZmmD7FEXZvq
	vLZMIexhrDRaMS3+ehBqAu+fwQixR8R3QsgumNGtjIPAdNnzOxgmzlZ5
X-Gm-Gg: AYBFou00ImD/a08ZintXqNh957Dvco3pfRBzdX8tD1d9PGwG88ZcdJQ/SXFurBFLZB8
	H6dj3I4D7LowRUS3RbTvdXR1ogEUT463v6sPxA6JrGqMAiMzY0nGw2l6tQgkDV1tkHyMQsb0NEB
	v5UZZ5WC1/V+MGORilSONip5rPg8r93WlSAKE1SMky9Danooios7RQR9xODG3pAUE11XpUDWq+S
	dntkC/syySQsdlb9oUBc48W/K5wpBsTlnr6aX2ycMVgdtlyhm8WaItIAIiojtu/nRYyrnOYTkhT
	5OTVT0DeWelM2ixi5Q+hN9z69WeiLvGLxBQauh5UyJZd2qEa52G1ACvjKo4fjsLxIf8Bs48q0tD
	Wig9XIUTwnqF9HAzgMmLg6XCl1hTKG8fbqMMvoFoCjFfV5ErMRLvTOhnFJCY7PpQq7sr3UXI1LJ
	GMulkNwbaV0l3OhL6D0/G4N09Vnc9xqiRVHIK7ZP2DiLeq+hSrnu4w4FZHU5Y2DfOViWVScEBrd
	wNWS/UwFJo9HNAOPHtIIJHtZmRfXXwe1f6drYXvQL5TDBo54BY2FSIuU3DsiDMRYXjutvR4GJL/
	BZ8GbV75EsO51BxhIq02PwLIG98bCcOeWBW4Sp6fE3FT9JcgwJ981KN5Gzx1ycRG7+K5ywtaUMD
	bVeD+00s5/mc2ka4VR4dagtkLlalqXxodYw==
X-Received: by 2002:a17:90b:3a47:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3b1b0d7e539mr149037a91.41.1794516398718;
        Thu, 12 Nov 2026 12:46:38 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d257a0sm6330400a91.11.2026.11.12.12.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:46:38 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 20:46:37 +0000
Message-Id: <DMTIZ0EMQ6HE.7OEA0L4EX96X@gmail.com>
Cc: <andrii.nakryiko@gmail.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf v4] bpf: check cpu_possible() in per-cpu helpers and
 map callbacks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "bo cao" <treebacker@foxmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <tencent_6A1D611E2DA9545DA6E76ABCCA806BC39707@qq.com>
References: <tencent_6A1D611E2DA9545DA6E76ABCCA806BC39707@qq.com>
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

On Sun, Nov 08, 2026 at 06:43 PM bo cao <treebacker@foxmail.com> wrote:
> @@ -133,6 +133,10 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
>  BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
>  {
>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
> +
> +	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
> +		return 0;
> +
>  	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);

bpf-ci is right. All three callbacks have the check.
Drop this hunk. It's dead code.

>  			if (returns_cpu_specific_alloc_ptr) {
> -				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU;
> +				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU |
> +						       (ret_flag & PTR_MAYBE_NULL);

This is a fix for a different bug. It doesn't need a sparse mask.
bpf_per_cpu_ptr(p, -1) returns NULL on every machine.
It may break existing progs and needs a separate discussion.

pw-bot: cr
