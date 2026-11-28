Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826017;
	b=4gaPhYlzkjFNIt4zna3fLuTOV9SSYz9UjogsRXqdw9RoRBwmsxNABxsHKfdtI1m5qyzE
	 HVMS9vSyjZf6hmVprbD6kwh5T19dY8PSuYVP4N414jsr+Dlr4s+qvpYNOlrqEQf0dw62/
	 wJ6LZhwQxqEwX6DAy2rwBKaigPt+D3SK0yl0BQTlPQ5N4fS+jTu5NGBTPRKDqR6j4LV0w
	 TyyH+tydafora/KcMnTM2MFLE0PI48t4zjNKD5qCdoCKhdSBh5YLqt1owwg3tk1zY0AgI
	 dlXNUGL36yyjS/NJ5XADJqVFzg9HHZqWtFGqxT0Gy7fAF0eiNw0BfsMLfUNGSAE98jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Mu5WLrjeCPu8S4oqgwQ27bq4kiYqk+zhWBIQ00PCvk8=;
	b=QsLiQGYsD/zxHaf3L5xHT/y8Bdhw9y/yhiBplCD3Gr5PlHdLdi/Mt+enOFAnniKWS+SS
	 oSlbEFjZWyKEFyuKEfMwNf4hXa7zp5ZALTJb4mG8cCcjr9oVNXX1Er0ncCoPjMA8KerA7
	 0U4P9HbU1p9njQu6YBY6GvJB7o2nRXwHKV7kg/8/p5I/4U4k3qNkLEY4Usw9P8aUriii6
	 8UqaTEFfRpizJeqgnQCwORyx4qdsJiTO+IuPe7eQjNfMChQ0f6j2wpFeU1bnZlMgPUA9X
	 z5GFW1Pl/srpJwqNsaaepFoy/BQZOy+nkXWL4NMgKAqyFyUarIWdKHzFK2G24N/4VFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VtEfMRUf;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284B606A31C
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 00:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1284B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VtEfMRUf
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso3464610b3a.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 16:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795826016; x=1796430816; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mu5WLrjeCPu8S4oqgwQ27bq4kiYqk+zhWBIQ00PCvk8=;
        b=VtEfMRUfZ3zyteX9vboA7JB9ZusTTGvzZOPMC/5Zmc5unjfrfu1V+L9VEVEdpbLwwm
         +pH3uXa35kaCWPzE4JrKggHljzEp5AKNSP0EWh2laOQZ91sB1pFNt1rAH+CwrZpzhuqU
         Kz4Yv+dgt/w/cahpmYsq9vgnZgcCuqTU/we5LM1IYaT2PqzE0NCasYG0QurDtaguHiiQ
         HNsHiqpCOkedaEj4y3PfBloCVIuAhjA/qv/S7hHqOrH6KRZG7IC/OIWrKVXyIGeyzv53
         ZWM8Du6OSmMvh3h18mCQ2AM5367yKk5sLJv4e8+DYrWAnMLRvrmH44wJXi8+qQT/8J92
         neyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795826016; x=1796430816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu5WLrjeCPu8S4oqgwQ27bq4kiYqk+zhWBIQ00PCvk8=;
        b=UOVO1ub0DqrI2RVpjbwWjjvKRHKMnJ4Aw1KI6IFJHwxpdjKCjVKUOP7AKHpve/P4gB
         Head1boq399d7gD9UNu5eqpY9cziS1gsVsCAttYq/AK/x7b4xFPdDrPLT1XL7FcaZhLB
         eiSX7FhLcfpcar8TdXQkITvAuRYS7Wdb85vMvd8q0xgHJXK+5k++JAmYCnaPpHb6v7vY
         MmGncKPFLtCMfMkHARj3myIeruIEfPiZi0F5YQDxF3wiiyG8iuiqMOUAgQOwKVwPVMxF
         cjFkUpphkkXt9sDf5pcquELyh0excsv5PCgvVUcKHZicPtfQsj8mQgqKGJeIZWktATsy
         q0Nw==
X-Forwarded-Encrypted: i=1; AL+hErHh3CkHrm9ecJE0tngJ0bDVhZUpBnFgKWwbG9TvUjvWLTjFtxmtG/zDiV71I7o4GNF9K1M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/9wwW48GK3d+vD3D5Z67JP6CTsyNcxFfYWW/cmqa265yH2SoQ
	OdhAZsEl9op2ZPqy+9lQZiBu2DTYO0O9g/dkvvALCdAun1Jy0tedw4SH
X-Gm-Gg: AZFdTZdS399snv7K79L5K1eUbxVVpFZlMCMJa2LBCwATI0YMtDMqD0c/d2EeMlveckR
	x7W9Ms3xE8JDGLdFr39awG50sc/5qKgsQx9GTg+O5lnX9YegGV0f8vSPXkEfjg5cPpy/VNQ43MM
	eNSSvLGpil0Okls13UMopCIsUUI41irV49g2FWMaYrQaSFmmhMhv7lzSWaHlClRNPENGma6wpTT
	8K0EXHXWahWOEtwzW/NWtlM6ONU/tIbi1fTpAZzdXNsc+8VlBw5kv0nIXBumvPhBecZqnPGwwWK
	B6MMPVuIrou8PFnLpT4M1SMgsXAjtF+TZrzSz4tx6ZMER3rFtkMsPuWWcEkmcbObkKZ2lkUz9Pr
	0j8z5PVmmqI6fJVW3CPeRjin3qxMuQxONmW4duaOads8rkysxuxJFkeijNLeP/1d50Oph8+lsWw
	LoTF3YgJGugfk+fftrAnlEAkQn6riIZs5k6PPLOv48jOB+Hx1YpP+9umHMD71IRD8UZnS7uXz5M
	ktKnoqHMYQqLS2b01zJw1jumvXEuQe4GFm3opUeN/JNKffVtxwpBGIGDRwFGN+mcDGxBoB6liEY
	Aws6ppvrDM6Fq8Cx651l1kjGc/C22IG8BVO8nmpqJ+rGveacbivNln7vDuIwWDGJzLtuGYQ0uQn
	IdlDSfuB5MOw+AGFW6DIy8MeINeNRQia3qA==
X-Received: by 2002:a17:90b:4b85:b0:3b0:96b4:ceb7 with SMTP id 98e67ed59e1d1-3b41c7c2384mr26668854a91.8.1795826016052;
        Fri, 27 Nov 2026 16:33:36 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm30793634a91.9.2026.11.27.16.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:33:35 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 00:33:35 +0000
Message-Id: <DN6F6Y9I0QD7.1B49UETL2EKDJ@gmail.com>
Cc: "Kees Cook" <kees@kernel.org>, "Andy Lutomirski" <luto@amacapital.net>,
 "Will Drewry" <wad@chromium.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Jens
 Axboe" <axboe@kernel.dk>
Subject: Re: [RFC PATCH 0/3] Introduce a classic BPF filter cache for
 seccomp
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <io-uring@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <5b1c03a4-f910-4f97-af3e-1b8c328dd1ba@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com> <DN0AIFQ82CFP.34SDTH6ZFZC1G@gmail.com> <309b8e49-2f9c-4a2f-9b40-8e7e7cce3455@huaweicloud.com> <DN5F4EBDNESC.3UOJRTCXCL4HI@gmail.com> <5b1c03a4-f910-4f97-af3e-1b8c328dd1ba@huaweicloud.com>
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

On Fri, Nov 27, 2026 at 07:15 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> The free path is dominated by bpf_arch_text_invalidate(), which sends IPIs
> to all CPUs and waits for completion. The wait happens after put_cpu(), so
> the task is preemptible. If the task is preempted, other lock waiters remain
> blocked until it is scheduled back and releases the lock. This can extend
> the lock hold time to seconds.

> After moving bpf_arch_text_invalidate() out of pack_mutex, the p99 VM
> startup latency drops from 2.79 s to 170 ms under the same workload.

Awesome!

btw every free still sends these IPIs.
We can probably remove them.

aarch64_insn_set() can do caches_clean_inval_pou() only
like aarch64_insn_patch_text_nosync().
bpf_arch_text_invalidate() is its only caller and nothing runs in
the freed chunks.

It can be a separate patch, of course.
