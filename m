Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B7376A12;
	Mon, 21 Sep 2026 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018134; cv=none; b=AbGZeTeKa6rIzFTfM+/j4XJ+q5jQyhoUCgsfh1P4BK5MdMae6H/2mimhgMm8ZMBeHPFjYxpGfu7tSx3olNtyVQpapgwzzSJX6vNXVi641OwB+bCh6VqnykrTu168q9gbsVUkPzdnAymcaeS1fObUcWx+rltz6MAmKBDgKVQfnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018134; c=relaxed/simple;
	bh=1DtMai3V3kiVLqjineDsFbm8zZzMEdYBtgrN2LZaJ4U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=nq5jNvNjai3a6BxldDO2CbX+h+WsFKHgzOITTKvqVSptDGUqfM8+QHQSRxOaqyCcM7zRehvS2EctypdtAV6QopQHZLo2EIxeLxqNGeZT/nAKowfJNQbegcmUwc4nKVKZoSshgsnfkHQpWZhg2Cn6Qa+TEZoFq+YOgKqIt5sfTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a02abwHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a02abwHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A774D1F00893;
	Mon, 21 Sep 2026 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018133;
	bh=8hSkDufjo3UYdhcc6/PO/YCzjZj51zL1OxsBdaPWaTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a02abwHizeexXH8wXiUh7evoTHc9Ls8fAxrcjDmU7yj6FsKDRJlPXezmUTV71uNLk
	 XTvEYUD9RzJrG/RmhAe6dLgFmL4RgaC0v0qyx1EnGHRUE7l++xgBVuUDr3M0vTrNQ3
	 rmSwLh181vfoqYzm1+VMwjJisKVmoNGaMtXvt+YH/H4j/sSi9IoLMvtu1AG1B3IrCr
	 6R/lsdBHuyOPF6szN5jipDH6wSkFEfONxM4nfQ56dzVX0ffidfYURERsyHtIpsCbDk
	 W05xC8NdL4rnaMCRJ4T1jwLa0NHIRQNaY62u2++sE5VngSEwsOZPvBjrlFxoItRX6C
	 IWuZljjsykTEg==
Date: Mon, 21 Sep 2026 09:15:32 -1000
Message-ID: <2460bfe776dad67779dbd5526c14d31a@kernel.org>
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
Subject: Re: [PATCH 0/2] sched_ext: Specialize TID and scheduler hashtable
 compares
In-Reply-To: <20260921185943.4031480-1-usama.arif@linux.dev>
References: <20260921185943.4031480-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> Usama Arif (2):
>   sched_ext: Specialize the TID hashtable compare
>   sched_ext: Specialize the scheduler hashtable compare

Applied 1-2 to sched_ext/for-7.4 with the scx_tid_cmpfn() signature joined
onto one line.

Thanks.

--
tejun
