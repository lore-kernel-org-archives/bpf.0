Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298343;
	b=IRKQ9Y0vsLXgl7e7Iw3Lhn6bgoCFqZ577WFk/GOgNXP8aejoTkEf3fCCMdoScZaR9t2g
	 PYatqzJUn1ySkvQpbcQs0sN4lTy24uB3O61c6aUWcp3eAcWP1PB0H9L3hR3ROkpCdw+PR
	 30Ph4NXPmDbHFcLPh8F+LCLil6d4q0C3tqATygSdxHJbd94KCaiQuYxX3NLQDXCcuNUZS
	 lCoB/C7UV3W2R0PKXaBQmGR2YnsobQY2Wvjt4Q1wgiSPeS2fCAdovH1jN/46ZnqAxQ6dx
	 /W44OPFy5QG2YK176qFIxjwz+yB549VyCuugvU483ysUz861hobcPLae745rJl51MUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kRA/GqoTkmiGWBF4UI1ZfmA1sH4CPsFD6H907heNT18=;
	b=ewzYIw4xbUNyFg4U3nr32kIl7MjrOuXeC75xI1ojq5EGNGTnfiwM65Xwb4Z1yIxBBIwY
	 h11aCK9b5jk/9YPoTzY5YFD6hlMdQKPB01yXS6W18yNvPchdCvjE8uFMEI3NuAzKCFv7g
	 feDpA7aD+nx/FDPKnIuFE+7jfAgQZsnvcf0VRvK2coyLfoS2rRGst4k+m+qJ63Rgi4ZIx
	 ULa7jkvMBTmjqZ3aRsbNDxYr77ifDY32FJxjhOxYURFMIz6tn+cCxo9WeWMHeuSGF9CGv
	 wgslr6EmzmLINEh/aeHgC39Nrlr0qvM14nNg1wFcVLPTWEf1wKxaeHqBFaKNeYEFG/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FNcb/ToF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109F606A33E;
	Tue, 10 Nov 2026 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNcb/ToF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BAF1F008A3;
	Tue, 10 Nov 2026 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794298342;
	bh=kRA/GqoTkmiGWBF4UI1ZfmA1sH4CPsFD6H907heNT18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FNcb/ToFXBo0a57yLcjgdm4o8ZirlkPo21GdiexYO+SlBCLgc588Oh3Tac0ltq0hX
	 KuT5Q2ILcIFzvAW7zdRfz+NDpoZc5VhY+879pf0ds5TmB0fIQNfOB2yT24ohrWlz1S
	 X707895w9JbfCbjYis0blINsCGLhfyDatr04unhbZB6D1HUYaiDRbAGDrI3ErR3sqB
	 jheP76alzfoGd6yRJtCIiwGkxdEfxnA19cEXkyqjbbUMmUxthIL1DeqhHywjMrl9X/
	 gZMxS2nagRDnj2MCpXSeeJLwbjCVN2lak++ylTaW+xnAgi1X6XyvoRvo1YhORXRDDo
	 YDm13MjFAUq0A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>, x86@kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 04/13] kprobes: Maintain an rbtree of registered probes
Date: Tue, 10 Nov 2026 08:12:19 +0000
Message-ID: <undine-1794298339502831052-1b6960b8f9b38e7d@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261109195517.1090787-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org> <20261109195517.1090787-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon,  9 Nov 2026 20:55:17 +0100, Jiri Olsa <jolsa@kernel.org> wrote:
> Add an address-ordered rbtree for registered probes. Keep it synchronized
> with the hash table when probes are added, removed, or replaced by
> aggregator probes.

Could you tell me why don't you use hlist (get_kprobe) instead?
I would NOT like 2 different lists which is basically doing the
same thing.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
