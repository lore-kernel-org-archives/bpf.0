Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414697;
	b=jFuxjwfRa3Mu7ae+x5a+FaeSIQTBEraRpdcLQ44pZDsPuy0KEI8r38ViIpvm6bsgwmcc
	 TQHp1hPlE19vgsKKyjnM5RUoMH87w6eph1a6tyfOI/f8BcI6fbE9Fh8Wgi06phtBQcuAo
	 UEuj8XTgopWPGvb+P3TNbc80D/OT35kKOV4JZgFG2eCAaPrzVCoLjSsa4nt2Hq8hA1/vf
	 ruhuIsytiJZQWLmE3DU9hkJsxoBQx46dLaPVkzLQyE90AUamKV/jHwwd48YD40121aZ6U
	 YE3LX0KPwnXDdjA+glZR9tO1Q52Vg7b/IiynP1EQPoZM+OuvNfhCrMTpNZoLI3iYsxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414697;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=APZI7CiU6LomQhDhdPfDm5AIR0g7StSMHorYfLj9NFI=;
	b=oUjU/YkSY1dQZm2/687N3OamPpvPMuFVyc5l5+ob73gmVrByFjsjHLvR57kWQsE1gpU0
	 TV8qaoGzUaRnM8a8mCB4U1u0I/1x00mhfxAYQWWw2v6E9KI59IwCyvFBr9faS90Sibw76
	 DI6ceAq+tAu8PSbLncg6GqW7MHuhK6CvGCSiw01p24Txs7KaGXynI12oB6/0yCo3xj1Kw
	 6HeGoWxlj8Scbdj+SLs3te8J1Bnzxyx6rls6Yb4VqLGQnybVfr0cyxxpTw7++IeQ0ADTu
	 Uk2i9C1Dl9992ZpKj7qe1pau4zJGvVYrPK6rszFdPWHMyKlFz3WIF+HWfIgNmjZyheg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MjJKuKR8;
	arc=none smtp.remote-ip=91.218.175.164
Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A46606A331
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A46606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MjJKuKR8
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=APZI7CiU6LomQhDhdPfDm5AIR0g7StSMHorYfLj9NFI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794414694; v=1; x=1795019494;
 b=MjJKuKR8AA2qE80ni2BQOis510+8i8823B8WV9JsRvMixHdGn+FU+Nkn0s878izMiEfRkSaB
 K+JLhrE5VEgZ7VhzDEiOF9kYl/FWNi+XJe/R8hkHvJMMl3SUj+cPrLJjjXlPv73K4UwI7DJsdLy
 6+loOYentyuGsWIocRNq6Ogs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4647fe6a3e7ecebd;
	Wed, 11 Nov 2026 16:31:33 +0000
X-Mizu-Trace-ID: 4647fe6a3e7ecebd
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 16:31:31 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: radu.m.toader@gmail.com
CC: anna-maria@linutronix.de, arighi@nvidia.com, bigeasy@linutronix.de,
 boqun@kernel.org, bpf@vger.kernel.org, brads@mainlining.org, brho@google.com,
 bsegall@google.com, changwoo@igalia.com, dietmar.eggemann@arm.com,
 enlin.mu@linux.dev, frederic@kernel.org, haoluo@google.com,
 joelagnelf@nvidia.com, joshdon@google.com, juri.lelli@redhat.com,
 kmehltretter@gmail.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
 sched-ext@lists.linux.dev, tglx@kernel.org, tglx@linutronix.de,
 tj@kernel.org, vincent.guittot@linaro.org, void@manifault.com,
 vschneid@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_softirq=3A_Treat_an_interru?=
 =?US-ASCII?Q?pted_idle_task_as_idle_in_tick=5Firq=5Fexit=28=29?=
Message-ID: <19FFF394-CD37-43DF-BCEE-594179867434@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Wow, the changelog is huge! Could you please shorten things down?

Other than that

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

--- Thanks!
