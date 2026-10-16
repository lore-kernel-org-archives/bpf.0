Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD702C2360
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119762; cv=none; b=P/P1G2+5CaeP8G32apyR4Q+2DFSQ/C4RrhQKN2GeZ306g4quQ6flZnYS3JAbPt4hZs4y+erUK7EAA06ISev+FCh2EO2KiGPVNcFY4VTjf9qI1YUHKnqzlqxN2XaUXzvyAVavQAWx0mMylBnTI2mjWPLuWIZD8/Nu5v5qYq1L2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119762; c=relaxed/simple;
	bh=Ncfi737IhfgoTSXedrzzjI4FEr50ydWxAOSaf860uDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCMDoUJMMC25RHTaX9ja8zhNmxVcnFv3malssPeX659cFXINEKe0pp2z+Vb+ishWCse20sA3/YNA7CEfg0Ri4x6jvYb40hbJpShDV7mQzrHlEJvTfKNJtbgZN77IhsKF8/2aqMTfPLMWQnGnPG85euKPLnuOTBKf4F8YQUwBzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Bcc94Z; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Bcc94Z"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f036b17easo1367352eec.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 20:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119760; x=1792724560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mg4v7BHfqkhi7Mtq+V05hYnu3rpb+ZBoFup4gff0eTY=;
        b=J3Bcc94ZZTdoPuZwv2gg4GhhisTH8hbOfLhU+PFZ3VNUR/cmHWpfZGN5Ipsoecge7Z
         hWQxlfza7KnnYkWXSHUSbIV3Ssg0jzFduamygASLv7HylbY4aCtWbGpWrsZ1t2dtLI6w
         7KZXX149JGPqBA1L8faJ6Lgn6N0qCuv1KsGmvquU0kn2Es+anjzBikCyE0ofmNxZyW0c
         qU8G1l4uHbvUwxSoM+7mvRY1AR8BXsYEoQ3op5etGn+fKcLAmHaGY8NgsSYiWG+3I+4M
         5lKAL41fPFBtu6/Vud54Csc0HAJvPHhnz2+6sh7qn3CQpyMMG9KCSlT26NQG3JAqqTou
         MYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119760; x=1792724560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mg4v7BHfqkhi7Mtq+V05hYnu3rpb+ZBoFup4gff0eTY=;
        b=hGxtg3nbFN/IH/RvX6K6/r97aFO54GGmCYGOx8AF6q5EagJBv7TZxgEHUFA9IFbiI6
         xYS73wTle78jAnY44yeXxmQ9EaLOYMZg3xOdvxfMuBgvMbyKk4rBEJPA6i51vCu1p/P6
         Me6dpWJf5wYvmCEpURVT5bq5cV+um2z1fJRbbq4DckByyctexCXYKQlWE+nN+lSlz/hZ
         h37hFwN2w2Hmj6Y9uxSjy9WHhNaDM31RWOjQMc1Z4GpSt6A0iC/Pggxav5vic2Pc0kEa
         BV0mU9slZDhf3+X7qwCZ57kRubwWfV5Xch/ddw0u5vgE6klEPYD33/D98a2A0njF8KNN
         oGLw==
X-Forwarded-Encrypted: i=1; AKwUvBxHxE2+uuletRVnFr9qd6j+TUlIbDz0W3PlbN7xdIgdih/g8uLCG2QF1WNg6zQBECa1/Iw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvSEEP4XGq+imkiN2Z0eCAjj+zt/qFGTRTKRv3hJrEQ7tqcBR9
	/RGF5w8iK2XMFJ/VtTwXLH4mThImDd7KbomWlA+Aa6kFPPAL+/eS0aLP
X-Gm-Gg: AYBFou1AqJfOqVM5fnwXneJ8aU4HddhS25KgZTTv+rJReLmstAqhQj377hNAm4a1Tqd
	9wYaCuVth2ap2a0EeI+yMrGWdG0kJleilM/0JaGL2vaNohb0ZsNUH1SoLH02KZwZ0Su1vHYxQ8H
	BR8tWEAD2bsDzatsrs6xmQs1oviuWj+gxJAAi80qc3oMJ3q/6iLMWwwx57aticGJ2SO2kQpJXDR
	KWOn1iuCaS2BoF8tOevh7iBqQdXojSAmff2fyyWWXpV8Yl01OyoF2rthT0u2MIqyvBD5/yWdjOP
	gN6K1ybC9Gm8hYTs96zivGCpuguCndmFQC/X1yLXqFdHMx99N9fBANkx6CLR8LtV4NHvAYMnf2y
	thmm15qAosXoWSMHPHrTmzyFfVNY8a8QBbqanQ3OkYPvUAlyQes9XWk10M1TYVgW+bdOHGd28V7
	D2ufyMcMBzLJbyzspATLRieZ+cq+7mmpwLjKPPKbrYdzzdRyxcEDfMA6nNDuVUYkA=
X-Received: by 2002:a05:7022:3b86:b0:143:5266:48ee with SMTP id a92af1059eb24-16a6535ab09mr30808175c88.42.1792119760148;
        Thu, 15 Oct 2026 20:02:40 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm1913846c88.0.2026.10.15.20.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:02:39 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix a struct_ops use-after-free behind a flaky assoc_in_timer test
Date: Fri, 16 Oct 2026 11:02:33 +0800
Message-ID: <20261016030233.3429038-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMB2axPRjfe=ROzA0rMR1_FPyv1mA-jaH3bHQHZje=Q1PjoEVA@mail.gmail.com>
References: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com> <CAMB2axPRjfe=ROzA0rMR1_FPyv1mA-jaH3bHQHZje=Q1PjoEVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 10:41 AM Amery Hung <ameryhung@gmail.com> wrote:
> I think this fix is heading in the wrong direction. The struct_ops map
> association was designed as an RCU-protected pointer: asynchronous
> users may outlive the map and observe a NULL association. The existing
> selftest explicitly verifies this behavior.
>
> The problem is that the disassociation now happens after the grace
> period initiated by bpf_map_put(). Could we instead make
> disassociation safe in map_free_pre_rcu(), before that existing grace
> period, rather than adding another deferred-free path?

Agreed, that is simpler. v4 [1] does it in two steps:

1. Replace st_ops_assoc_mutex with a spinlock taken with irqs disabled,
   and put the map of a non-struct_ops prog after dropping it.
   map_free_pre_rcu() runs wherever the last reference is dropped,
   which can be softirq, e.g. bpf_struct_ops_put() from
   tcp_cleanup_congestion_control().

2. Call bpf_struct_ops_map_dissoc_progs() from
   bpf_struct_ops_map_free_pre_rcu() instead of
   bpf_struct_ops_map_free().

One thing to confirm: bpf_map_put() waits only for a regular RCU grace
period unless free_after_mult_rcu_gp is set, and no struct_ops sets it
today. bpf_wq_work() runs the callback of a struct_ops prog under
rcu_read_lock_trace(), and that callback can read the association too,
so v4 sets free_after_mult_rcu_gp for every struct_ops map. Would you
rather leave that to each struct_ops?

On a KASAN kernel with v4, st_ops_assoc_in_timer_free passes 100 of 100
runs, where it hits the int3 Oops on run 1 without the fix, and lockdep
reports nothing over the struct_ops and tcp_ca selftests.

[1] https://lore.kernel.org/r/20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com
