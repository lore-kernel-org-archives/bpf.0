Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640669;
	b=n4ELJd0F0Wy1Eji8Fxvy6GsYaedl8haSL9FIaRQqiAGdqSF6Zj/pSWzG+m1XztPnZ4PZ
	 h6Wa6G/zDmnE8wMYZfnpOX6OWWYYlN8APPRWTpP2uohM9VXdWzN6iC3We7zk3FOhsTBA7
	 kdkMEkwcbEp7uzjdvT/s6YMxekaxsBIvMqoWF+CiWbpjaZo6ZAL+Ot10lpLHD4A4ihuTl
	 qOAq6QsbbAbtvtImz8OuqvlO0vOwPjlUJY8mPnNok2KNoUzvqbAoTUFhvqzdQ35/MwOVN
	 uzXtJ8D3HKZnAzdi0Bl2HC9bBJ6MEPpwXDcWAnCSqt4rMP8t6Lj8VZYfvo+jWg2cghg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640669;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=rg/sPcVtUjjQepOXbFb5wlfcZCgvEgAE5db/aqp+jsTNg4OEtg6iUW/FMWq86KKFM9rD
	 spjmdouVTdmbHz/ynb/YzYxBeZqcIHMpogjZkqJe5cXaQf8Q3HpJXxIhviEB0k8z7KPJU
	 FADqB6Y35l/SZLee3sEsn3Oa0YZZ7EDyKfgmtBWzLSpiPpNEWGmnCqwKT7tBEHhf4thjC
	 Vb8P7+d4IYOH58HCPVYSG8RAL3ltF0vJNze5CmbSuc2+7yzwqZt7qzw/WdLuy28uxGp6V
	 dDuM2JynPZwMSF4qDH1WrNgNsSSR4wD6XU7cAJtornmMBnt1F8BWjKM3EwFA2mKZc5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T0sdT/qa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80896074A40;
	Mon,  2 Nov 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0sdT/qa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEAA1F00A16;
	Mon,  2 Nov 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640668;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T0sdT/qagLPsh1dT9CFEyCDaQvde7TFgi7J98RpFmiAdRA8A6rLQADqN3iZcHPYm5
	 IcN8UAt4l+FPXl5Wvnxrfx8T95ga9J8iqAJeOnHypMZJuQXEMQRiiIp8To0Qb1MGan
	 fQFRnGrrVBOgcAJtPbnF2Q/Ae0brRU04a0N7B1zN5FcpSMZ7DUPGGK1W55uE4PTOHY
	 pyhnxaq/Y/F5uDxZhxOy65Rm3+Pe9TATD/4apik/0pheHy4rSt6uIQwQ1dUvN0G/UP
	 ormQ3AViCG0IxAL19LZjV51QSBPqLDZlTNewFf4+azhB4jYjH1P4RUGdoM7QRRu0Qa
	 +F4erc47afs0w==
Date: Mon, 02 Nov 2026 07:31:07 -1000
Message-ID: <387c9ba041c3e1f0923b36141cf36462@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Josh Don <joshdon@google.com>,
 Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>,
 "Christopher Lameter (Ampere)" <cl@gentwo.org>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject scx_bpf_destroy_dsq() in tracing programs
In-Reply-To: <20261101-scx-destroy-dsq-tracing-v1-1-987a7f2f5bec@gentwo.org>
References: <20261101-scx-destroy-dsq-tracing-v1-1-987a7f2f5bec@gentwo.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
