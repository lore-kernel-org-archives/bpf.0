Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507682;
	b=eKIidDTFx1MkGGDy8rpZ/dH5H7H+jr9iBNVBsjS++Ze8tBdXt5FJ7xMmMAJ5kzFYWfvV
	 lhfQ0FkgekGam8I3lQAy6h3S0XzasUMv1ZFGIodIxzB6cFZZ1heFhfLUEvXC8njOTCOgP
	 QQ0oiVCfkA6DAnzbIIw/w6NM7ohg0NiHPaqth3RGzT2C6xwy7KmYKwjTKXYYMHdNLOPIr
	 mxHvUDkPJrgC0IfGeWAQp2PTakXRpLj+C4iie+351b86m18TlUYyCq71miKY6Wi2AtLxg
	 EeS+qCTiQGMIKdQ5I6cmeYho8qiNmavUxS1sE850KvQwC+dX8ECSY6wNJPqEYIf5NYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=wbrg7teiEaZnv5DkKLxUF7WwT/nqBKWUsCVToNR2pF0=;
	b=lyN5Tz6CDECXQVifMXULjtf4Ak/ZgrQGUCEXCYfzr6H9VUIQ4KYbhh22OVc0w5cNJ1YN
	 JFB71w6Ahv2P+mhYA7sRadnvM/j5ZeRlU8eJEhxRJ6YC4qIM+vMKixtl2PcXqCxgqnZiY
	 FlB+gjlbTw55Z4044flUUjzC851XkGH7dvizzVuVrl2mM9FcELy9HbAf9bczDhAqABpW4
	 m3guoG3tXdnJRRJ6ZBJuyQGvqDt3CEeEk8wcbI/Sz1HRA353dV2NOmBvF0Nvi6HLlx4VP
	 AGSWPD6WJvj1zd2+9NXeB1Bq1QacZvjT6L/C34Mt9Y8R+o6OyBFroGSMMf8RUb5NSdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K023x4vI;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD929606A326
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD929606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K023x4vI
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so18851315ad.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792507681; x=1793112481; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wbrg7teiEaZnv5DkKLxUF7WwT/nqBKWUsCVToNR2pF0=;
        b=K023x4vIK+0AWHVLLYF0HDcHMEpd+ZXCelWlr7RM2y9pM+XDsljVqpvx1IsA6zrOC4
         TLBiw3bpPi3cIN4R2oThVdHLLlRK2seUDrmpgoj5iJWLxpEqjPNVmNiviRJnOhrcQKR1
         l0f1WRP2tU+bxfV14jB2KP2kJKI6k7RL8ucSy6N8Gysko4QxUXqSj0sGSH+soYD733Qz
         dPm/73d5KlOFddqlxk/a/7vWXtchP+ENdKT8MjECJbnsbuOnMzD34nIir9BieopYWrzD
         y6QhmHaZcJMAtJ+iDfPGguJdFOoISykHQovUvWAwjLGRU3+jz4wo0eFXH6hWWw+CKtDu
         p6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507681; x=1793112481;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbrg7teiEaZnv5DkKLxUF7WwT/nqBKWUsCVToNR2pF0=;
        b=YG3KI3I2bj9qLnbGDaCAL3oZku84xWPkWm4yNeW733/uv8Xxoo7Tjrk11WJV0O8d7L
         UP02ZHoNbq70XecwYEJR9srp/T/chU2O4gkbIlAkT+TbTPzsi71B7NtITVtFOEJg9e1M
         jIV5w9tYQa7Rg7a3ZCsKSRkdExQkLDi0mKsWwis238wmoW3/w7utsM/eExk2yCKhPPrK
         JiCMU3AnXtbhRQwx+bNcjZbDtE9TcyCHSHeQAwHiWN1w0GvnFtzfy9mvlESehsoa8oUi
         4fyM91fdvgz7sPKtobJESP4YevvRM4kOMdTvcp/u+X/4hNJWvyeHlgSaRSVIwqQ0Juj3
         Vbww==
X-Forwarded-Encrypted: i=1; AKwUvBxtWNV42kOIKWcMaMWktT1kxKrNq2iGhNuzhYRoslVrNif7OQFq8kpxB2gfURZx/ewiI0g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTXRVaWs0AJz8ulNvArQCAouvDdGGN8SM2ImZteXWMv6TpUud5
	5/YchUPY4Itoyp6Va/kJa09GfGn71Nv7WekzYtM8F8tHkBkp/pNRrdTHpyvM1A==
X-Gm-Gg: AYBFou0mK6C6UwdzI6HCm/5q50ujLDDHsOBfbQVh5GtF0Yo4FXVCW7MJLopfe8XJ905
	4nDzEr2T+iP6kdDQxy0sPQj1Ejnz2OEuBkAEloGO5a0YOIsRhwgS6WIjEMAadoez6qvSm1HreLu
	klLq8rsY6qAVLbLoNUOh7CBLWGPuQK5Dn2r4aOlVT0YQXflhqLMEcmSpFBY91HsGN1S+2ZYhP/E
	7pK6JeTmNJP4Brr8WFWM8EYQhtTBmthgMdRmSw6FW2kDx8ao3uYjBvjc2/rtSDRZReGtXYMXylk
	wFl2Rax9GMVkkiV21QNE+/bjuvr9T1VFanEPMv4MTl70erSWyZ3Hp/Uqs/NLFXM6iNQi93F/Ctr
	/Af9KzIKcA02tWD7jiLpDpkn0IzvY1j0wj7ggUyANdmjXPJdzpInmVTjpCXA7Vp/fRqEG5YDxLy
	608+KZuYvYeFyIf4JGjULg9AchZmp1Pii+G542i4YnZKYM5rWitVtgGtOEG9aC+UREKKqTA5Ki6
	4OKtpLpxHS6GgMTax4Y2MzV9JAzlgzbartftNcSRmhqfr3h8Q/57RMZvmFasGGQmyc97rIXKABV
	RZw=
X-Received: by 2002:a17:903:2301:b0:2e5:dce7:5c43 with SMTP id d9443c01a7336-2e9a6841aa4mr97854735ad.6.1792507680918;
        Tue, 20 Oct 2026 07:48:00 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151840c4sm13046815ad.67.2026.10.20.07.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:48:00 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 14:47:59 +0000
Message-Id: <DM9QXVWZXOHM.21TW53TSXHZ9F@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Yonghong Song" <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 00/16] Add percpu variable support for bpf
 arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <cover.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
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

On Tue, Oct 20, 2026 at 06:22 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> To use percpu data in a bpf arena today, we need to define an array
> sized to the maximum possible cpu number, like the cpu_ctxs array
> defined in tools/sched_ext/scx_qmap.h. This is not a convenient
> pattern. It lacks performance and scalability, and wastes memory.

It depends on how you use it.
Patches 10 and 11 emit the same thing as
&arr[bpf_get_smp_processor_id()]: load the cpu id, multiply, add.
The x86 verifier and the arm64 JIT inline that helper already.

__u64 hits takes a page per possible cpu with this series and 8 bytes
per cpu in an array.

cpu_ctxs[] is indexed by cid and qmap_dump_cid() reads other cpus'
slots from bpf, so scx_qmap cannot use this.

Keep it in the bpf prog.

Any arena offset is safe to access, so the kernel doesn't need to know
about percpu chunks. bpf_arena_alloc.h does it already with
page_frag_cur_page[NR_CPUS]: a table of pointers and a page that the
cpu allocates on the first use. NUMA_NO_NODE gives the local node and
user space reads the table through its mmap.
Then no need for BPF_PSEUDO_ARENA_PERCPU, the map_create attrs, verifier
and JIT changes, new libbpf APIs and libbpf changing thread affinity
during load. What is lost is plain 'hits++', but kernel C doesn't have
that either. Initial values are left to the prog below.

Something like this:

+/*
+ * One copy of 'type' per cpu. A cpu allocates its copy on the first use,
+ * so it comes from the local NUMA node and cpus that never run the prog
+ * cost nothing. User space reads any cpu's copy through name[cpu].
+ */
+#define DEFINE_ARENA_PER_CPU(type, name)				\
+type __arena * __arena name[NR_CPUS];					\
+									\
+static inline type __arena *this_cpu_##name(void)			\
+{									\
+	__u32 cpu = bpf_get_smp_processor_id();				\
+	type __arena *p = name[cpu];					\
+									\
+	if (!p) {							\
+		p = bpf_arena_alloc_pages(&arena, NULL,			\
+					  round_up(sizeof(type), PAGE_SIZE) / PAGE_SIZE, \
+					  NUMA_NO_NODE, 0);		\
+		name[cpu] = p;						\
+	}								\
+	cast_kern(p);							\
+	return p;							\
+}

Orthogonal to that people are working on slab-quality allocator
for arena. It's also going to be done completely on bpf side.

pw-bot: cr
