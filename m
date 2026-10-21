Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549589;
	b=d15bHshAx6tYPUaH/FXPa5gC/hmt+9Jyky1fACDBo8atj1LVlnOCCVM1F4GOO4wfjn74
	 epQCHU2jCjan+bpuOQDNa6mmbQ7ZYOHn6tiNjCt9b64I6uk/DZ81F6ssGx7C5yHpeOIzg
	 jv5VhZMELbTEw68FqBZ+ZaJizNKc2+nZhQ2VySa6MnEGIbwwXyn1NM5WWTwBm9OWGEKpV
	 ZYKa3AvTCSld1ed5KL2lwTcsMuYMVgvbusctKsg6Jh6Nx5HeTkI93srupamEPQEQ8EX//
	 YCISUjkXopPGfkBNDKFBdrbqZQMCkUIrUg4Kyczql+9Wh3xUANuQ5QNW9qVPK0NHT4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=qDdiu7ls9XDQIfTHarLgal/BKccCKhlDZU1D6BhXGx0=;
	b=KIJYoxT87SGUOIY58DsemlvfTKX+VKDqcy/MhqYXY5RALW5nzAAFeIp0gSbQSYI3GGsI
	 f+F1tEHhB+YfTJk6V2dyEJ53jm2lls4OhdXSbbxQNDgOn1fTdG9NHCDBX7yUKgfDlCviw
	 xBILHEagThZkMn/DoXFmxBLsD5+QLb8to4h2QUJBjL1R51BJ1mX9FlRkRsdOdsVxDLJlK
	 RD2NPwt0ZXAgmxiU6Nao+Zx34DiJurX7m576kSwtQ2rQHi0Ol8BHs0HVTknyW4gXl7rWC
	 SoSXQLvqLUXmZfQgl9VAhDCsXVKGFHOe53NZtE3f0FwixLaMMbu2Y6DBpn1hmy+fQHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WhaA0OJl;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50351606A31F
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 02:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50351606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WhaA0OJl
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5350d9ea106so3477651cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 19:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792549588; x=1793154388; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qDdiu7ls9XDQIfTHarLgal/BKccCKhlDZU1D6BhXGx0=;
        b=WhaA0OJl7jf8AS6CHRCl5npa46++WEicQwXYsexkMoPKqw9Q3h4kSIjeveOEPtOeQI
         jaYgiB0cl3NQJHu/keZ32MrBc98D8b4oLfT8Y6wNaiAe4UfWBuAToFWagfEGaxnddfEo
         qu5q7/qP6mmcY2TvC5vR+ByQUN9v7Rda4N5bBRjJHQTmuEfcxPtz6L8zqEu6y1AIChe3
         p3OgT+oiD7wRnr+UKJR08zq5slkVNPdFqXF3v//bXbAqokrcTz20l3opU0VcKVFOcRX5
         nUz0Ccc8hFuW6zQCBOz6lXNCEZGINN9h7Xrab7SHL4+NEFGXvv9ohf9eKYSs8mgT7FRw
         PUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549588; x=1793154388;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDdiu7ls9XDQIfTHarLgal/BKccCKhlDZU1D6BhXGx0=;
        b=qpZmM8NDVE8iN3eWat5OwjU2QdSc+0HrDzi+pbKng9AGmN+xreIDENhla0tE0Lz++E
         En91oEJ9HbJnze5K/mUfgD/+uNmQw9AohhGEjsFxiFpugjMARjpXzMB967v5+twgHt14
         6f/XPpMulIWJ/zrbtfbCg5RVxwsJMr13TA6XuJyqzJr086NgYoP5bMt7AEZt+3I0f2PQ
         AJ3IPiSHimj14cBI/oFd+eqZ/4NijT0N7R/0fNgCduxfGVx87Ynq2L/0R8Z2q6IO8ZqS
         GgxgMccfD58u1+6aX0R9kFTFw+1h+FbXCDnZtnlv7kGtnsTBtQvkvjqmQ73yYu9thKzu
         E+vg==
X-Forwarded-Encrypted: i=1; AKwUvBzVMBJ+deswRXwqX6w5pD1ujhAGpNm/uU2BoCSj4bkU9J+nJDNPhg8aHaeTAz1An+qiCX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkfdIQX6PekZPstHoFfAWIGUebAnPgnQVjOvKAwACxfV6pBBQ1
	VAcBQJkTSTZov9lXBLFjCUH5bXW8V+yzdPQsbOuZzq0xXNtJb8CDql2Bxc87ACY+9Pg=
X-Gm-Gg: AYBFou3U6pxzJ/k2IzyyNwVrJFZcmvHF0tEn19dfn3spRlwU5GbAEZDFlrjfaMz+1By
	IIY1To0ww7zTgGFAb30gzlbldT2fd649Wi1CjcxJghbl+EvGRSgBM4rfXqu0hAFhrMyciZZKUBs
	xteT9xgN/HMq6jFrZksyPleEd/T3AhmwyWeuoECDIXzJMYspFZ3gseEyE0+pJOZ7Ob/JBHD8fZD
	A5pUBxoQU8+3n2sQMJaRKVjJxj+8etybGrgH6K4oyaao1sF4UpYHtTHU8/bZaeCCZKGRLlsQSxx
	7MRMibzPp4cMfS9rxOLufCQYO10E90SKUx/dew+3dwt8yrYAhVHJy+6QgBVsDbHx1QHy4kB02ZM
	y+ZCnQ3O6ysi8/n7b4i7beXLrw1WM3DXeG1Lfm5WW6U8hEv4jckADl61r3j36upeM+exb33p7OC
	MXKmTWEoyZ+/I9q4e1ZIXwwGl5GLd5uwY2XdOmKNlx9tcOaOie4S7dNyKTlEgfhjjlTAEk+GaoB
	YQWAg0KOAraUxmycmyk8QP/PlYUtjsGuu1Gg/7o40yzBzfGkUbOdpqKp/j+rPzO4zs+SRuwDdY4
	Z/Qo8EDC3SB+71rpY1CMyqLiiAM=
X-Received: by 2002:a05:622a:1248:b0:535:a5f8:a5c2 with SMTP id d75a77b69052e-5369b8a4bc2mr10226291cf.66.1792549588210;
        Tue, 20 Oct 2026 19:26:28 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c42b17sm13170296d6.40.2026.10.20.19.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:26:27 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v3 bpf-next 2/5] sched: use static_branch_likely()
 for the NUMA balancing tick check
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
 eddyz87@gmail.com, memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 akpm@linux-foundation.org, david@kernel.org, gourry@gourry.net, 
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shakeel.butt@linux.dev, 
 roman.gushchin@linux.dev, yu.c.chen@intel.com, zhao1.liu@intel.com, 
 tim.c.chen@linux.intel.com, lizhe.67@bytedance.com, bpf@vger.kernel.org, 
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261019064157.29885-3-laoar.shao@gmail.com>
References: <20261019064157.29885-1-laoar.shao@gmail.com>
 <20261019064157.29885-3-laoar.shao@gmail.com>
Date: Tue, 20 Oct 2026 22:26:09 -0400
Message-Id: <179254956989.1919196.954997201143423051.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-19 14:41 +0800, Yafang Shao wrote:
> task_tick_fair() checks sched_numa_balancing on every tick. The
> static_branch_unlikely() annotation reserves the nop for the disabled case,
> so the default configuration (NUMA_BALANCING_DEFAULT_ENABLED=y) pays a
> taken jump per tick. Flip the polarity to static_branch_likely() so that
> the fast path matches the default.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

same with this one, this is useful separate of your series, please
submit separately.

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
