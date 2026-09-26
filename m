Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5834D91F
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437916; cv=none; b=KXahGFe8cEmUCLIwIA5sbwvI/cmURNRrjMjp0ye/MhBlyHbm7Z3OZ6atlB8/pOksKgOapzCYfJqWh2Jh4vrrtm/zfOPbby/Xb3+rulQjLkfa2MztK1d0E9TPv+I2z3a3iZ6VZ4lNeoR1+wcrB7WgsUFTICwV5ElJzuizF4ecUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437916; c=relaxed/simple;
	bh=b+i0D9X2F2S0Np++TT2ia1qmbBpvCbKPzmMUSt0WLg4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=iH5rn8Y+dBzKdzvyzfmbgUQOjr4TxLWLxwq5kJp58QA5Lj7wjvoQBdT5qGZifqHx43UV13I1UCjX8vMgcqhoBcsEGdhO/cbsrHM5scla8c3039GWR6PxUijUrwUxawv4d/VzVexfVzRavpoLDhUz56H4h+//GeO/e8zrS1WYkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMkCgja8; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMkCgja8"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1034742a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437915; x=1791042715; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KsnSXE0hO86vtMaQL0ebt/kiteifSy5eNA8IBCdtnCM=;
        b=TMkCgja82MooF0CfUYCFRU1BDP+8aFX2F7a/RsWAZB1xD59VFGRd9khazPNrw82GiO
         K2Jd9iHN2ZGyLLHiuVd8hAByPoyzp9RkDufpnhY/2T0JJcES07k2ueWvFgYNrF+U2jAW
         8XvPgUDjIGktXvs5WbkO6ZN4V3wztHV1LjuVi9FYc62jPATxNgBQ8IHpa6XB5hM707np
         AsmiznR6vUZU4YKpAFqCpjx2m21wywDG+tTDa38YF7OQktH9N73GYRQMzcTQ068FDgyg
         ulowgrs4XQHvAeixsvG1MZVXToyx4gV5UBowQUHSCh5kl5aFFQba0DOmami5CHXUjlvP
         w/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437915; x=1791042715;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsnSXE0hO86vtMaQL0ebt/kiteifSy5eNA8IBCdtnCM=;
        b=u8jYdZqxL8ZgMjWbnkXjvgApXcs/o9/eLkdspEZqO83fftZ6eB2o+JE2dHNcOwuqeX
         rOjJiEmk5ArHGDFWEHKji+2TKz5e2yaibzX5wCa11XO6Rm07Cde/5M5DXGJSgJYkz7cM
         mAUdrcUaSzwTtVqh/zIYAoDugMwEkzK2vgenw7fZ169WGNWseFki++wIsQVrTv5QY4DZ
         aqk2ErEx+3ry/vBQgkYMN3/8DFhme6IFJs17JmAyFN6iydy0Anqvi/wKmLortSVaS5Fc
         OWhDIr7ZBssKcnQQ4sE3XDH/TOutMRXNhDSGgDz1mWH5DQPwIpwf3KW8XK3BGfRsxIhd
         +9vA==
X-Forwarded-Encrypted: i=1; AKwUvBxLeJk6JKDr8rjeOHe1iczY6U/Pczs6KNxYkQtqRRn5f3E46YNHuS73e23oCYDotOTBf+M=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1RtR80BmueNO6DSKo2BcdX1U2UJAur5Rmn3ecEXhH5/rZxb2d
	K5StpZniqmQ7JWh0Ua0+hG1flSCsEafnVGhMMogJs9XVKfCPp/7XTYU3
X-Gm-Gg: AYBFou2ieNCKnhnBXJvgwE07mDQ2WCJ9e9iSQx25UqA7svk6Dxyo/voxpRg4YcMDdFz
	oAJXT4fvSplL4agDPhOJmW86mnBjoEUEwPuokT1GtRA00BH6HIMyMS82dbW2jDWjdG0uvpn3Ji9
	yg6A3yEBjGluXQ2uvUlwqJOUti7WLP53KQlQhOOFzFuKFWaIvJrlP0Ta7O+gAk+yN3vDJbVZlz/
	JaaBL9LB5Djg8HoRIjOk0t8AVcuL4VxlCbJH+OI+NRLsIfk9nVizpf8Xcay6+9rjR5dlbCMZUaX
	is46nCHCAaPZ2gmkUo/NzTMvzZIq9wCeatcc3kVE/QYaYDJsfZCKPT/NqieFf+iXYaP7QCnwwlO
	XsQLVDE6ksIp+oi16Wir7yGecknyluSlNvWyO+1T8N38d/U1lknoTaXGqwBjYsle6CTGZ/iR7r0
	BzjLxF81PpGuRY+fHmwnukFxj8awPgh9pWgcUsGo4JQ2M7D+2g6Ws19HLxQxuk/aBnywHXjC9zP
	QRToFrptYCgV4bDJFqHmBtEoiSK7RcjI/+GDTx3PV9LY1IcjEA8fvw/2Tj+q5Jbhu8Hg7gcHzE1
	yKHm
X-Received: by 2002:a17:90b:4b12:b0:39e:6c6a:4b78 with SMTP id 98e67ed59e1d1-3a098e43c20mr8101152a91.66.1790437914882;
        Sat, 26 Sep 2026 08:51:54 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5dfsm16527115a91.3.2026.09.26.08.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 08:51:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 15:51:52 +0000
Message-Id: <DLPD9Q4H9C62.2QMD510XIOOJR@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 02/36] bpf: summarize may write stack slots in
 insn_aux_data
In-Reply-To: <20260926-scev-minimal-rebase-v1-2-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com> <20260926-scev-minimal-rebase-v1-2-c8e5ab5ba79f@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 26, 2026 at 07:20 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> @@ -662,6 +662,11 @@ struct bpf_insn_aux_data {
>  	};
>  	struct btf_struct_meta *kptr_struct_meta;
>  	u64 map_key_state; /* constant (32 bit) key tracking for maps */
> +	/*
> +	 * Per-instruction summary of stack slots in the current frame
> +	 * that this instruction may write to.
> +	 */
> +	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);

That's 32 bytes per insn and the next patch adds 32 more,
for every prog whether it has loops or not.
FM_MAY_WRITE in patch 1 makes every frame_masks a third bigger too.
commit 481ceda77aeb sized the liveness masks by the stack the frame
uses to avoid exactly that.

bpf_may_write_mask() is the only accessor.
Can the summary stay in liveness.c, as wide as the subprog's stack,
and only for insns with scc != 0 ?
