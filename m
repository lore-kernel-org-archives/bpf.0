Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821E3C10B9;
	Mon, 21 Sep 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012417; cv=none; b=omTo9SSRADtpGvJTqTxd740/fC38JfP4PW3wiqkI9DCAgW01XaFpQnH9Wks8LwUBGzXoXg3zqQR0EhMeRQvK235vmiksJOLlBQGkoV2uwLoOyTicSTa8cFVbLhmGznUWsepPqa9EhGQZTWK1UvRATzh4KMk1cQIXa+KJdwjWlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012417; c=relaxed/simple;
	bh=jD1Ry46DGVBPEXo6cyCks+UGuJM0O7YxIFBNv0kjY3Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=p6TQakz9kDfyzvkH9NpP6eYvdBMm5EpO9zcRwnK5DsxjF8qbcTFJGGOgW1fF7y7jrS+KtXxNPFhDQFsuBNApgUj/qV+NgS+LOQSOdvydQm97cU03nxstSVqeSTkgVRFGna8WGlVQDulDcKZ/eslAADiVsF/A7CzjSnqnVEW4T4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK/YEveJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK/YEveJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87811F000FF;
	Mon, 21 Sep 2026 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790012416;
	bh=jD1Ry46DGVBPEXo6cyCks+UGuJM0O7YxIFBNv0kjY3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PK/YEveJf6qjG64ztoZ5i/O/cyfiRIBZNtDbNobQodpaxCPEvB332s+j3pF5+Ljn8
	 qCbyl6gwYku78q3IjiAoU4uG5hR71lf4cMrz5jTgO6zGflTjKoeflKSiezcJ52wCCN
	 HbKRdeeOyg3F0gRTXu8095HbC9JpL0aWA7VAxVwApSs+y8V6eaBgx6AyxiyIiclIeS
	 0c1x/43XGnTghUT2JNaqzSN+BDYLLAu0fAgwdygo5M9dl+DHgFsLz3Ce6uA6sps7zt
	 rW/6y1EJTQnYtEBRmWGm4+I6RE0zUnLojuD8FvKKZCADWt4qjAoAi1pKemMi9AXrXZ
	 Kms4/t3OCBXrw==
Date: Mon, 21 Sep 2026 07:40:15 -1000
Message-ID: <a29f5b829952f6a8f15128a4115c5765@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com,
	bpf@vger.kernel.org,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	etsal@meta.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yphbchou0911@gmail.com
Subject: Re: [PATCH] sched_ext: Specialize the DSQ hashtable compare
In-Reply-To: <20260921171928.1639407-1-usama.arif@linux.dev>
References: <20260921171928.1639407-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.4 with the dsq_cmpfn() signature joined onto one
line.

scx_tid_hash and scx_sched_hash have the same u64 key and also fall back to
rhashtable_compare(). scx_bpf_tid_to_task() sits on hot paths too. Do you
want to do the same for them as a follow-up?

Thanks.

--
tejun
