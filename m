Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55D3043C8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012805; cv=none; b=a8p6idXRsPYobFK0aUfSJXIrYk3rMhwFfUILIdqumdS951nk/RoAvaIbtUf7+90b0UazQ20WkjDcqHPFXoCdbopfQx+6yWEACn3xgDB9Cj5mjuz50CP15PsEDwIJxFLpRUa3Bo8F0YTBbWGk0af0AI3KjbUqZg37+unGBjFjzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012805; c=relaxed/simple;
	bh=64lfCXfUKLeF20RwvIRRfQ2FAbTLlQvRGhRFhAU69ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPmvJVT68Z1LOqVMn4I7uk10qmo3qVicG/amlnoW7LcO8z79VP/uJNPS1zx9Z35GR31fJSNCRE8LCNkxVLtcOhIDXubq3Hl6gGqgfuSR+61turlU07tkf6ZnsN9j0qI1JWlRAlmOhFMhyLjmNHjnorN99F92XDnt/QHAEeGjWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQp0lvGh; arc=none smtp.client-ip=91.218.175.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQp0lvGh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=64lfCXfUKLeF20RwvIRRfQ2FAbTLlQvRGhRFhAU69ow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790012802; v=1; x=1790617602;
 b=CQp0lvGhEUIwULRGwidEEZFO9V7On3HX/Fwi+WprCz46dULhaLOdDhidByqc74xC/nkHzSmT
 eehX24Z8plVmdXv1BIJMOnZ6eQa7uGc+gkzMphB/hdt3kJbAuYi+cKPXSPoVLKK7nkOVH3xDkDV
 kdU1zcwslnUImqpmHt+VN83c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c77fd262556d35a;
	Mon, 21 Sep 2026 17:46:32 +0000
X-Mizu-Trace-ID: 2c77fd262556d35a
X-Migadu-Flow: FLOW_OUT
Message-ID: <0dde6d25-540a-4acc-9375-0df16f1b835a@linux.dev>
Date: Mon, 21 Sep 2026 18:46:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Specialize the DSQ hashtable compare
To: Tejun Heo <tj@kernel.org>
Cc: arighi@nvidia.com, bpf@vger.kernel.org, bsegall@google.com,
 changwoo@igalia.com, dietmar.eggemann@arm.com, etsal@meta.com,
 juri.lelli@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
 rostedt@goodmis.org, sched-ext@lists.linux.dev, vincent.guittot@linaro.org,
 void@manifault.com, vschneid@redhat.com, yphbchou0911@gmail.com
References: <20260921171928.1639407-1-usama.arif@linux.dev>
 <a29f5b829952f6a8f15128a4115c5765@kernel.org>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <a29f5b829952f6a8f15128a4115c5765@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/09/2026 18:40, Tejun Heo wrote:
> Applied to sched_ext/for-7.4 with the dsq_cmpfn() signature joined onto one
> line.
> 
> scx_tid_hash and scx_sched_hash have the same u64 key and also fall back to
> rhashtable_compare(). scx_bpf_tid_to_task() sits on hot paths too. Do you
> want to do the same for them as a follow-up?

Yes, let me send those as follow-ups! Thanks!

> 
> Thanks.
> 
> --
> tejun

