Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186C35B137
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524146; cv=none; b=FwWAcxTj6DGQWcS6LfPKgeHzXdGtqLu5Pipuh+XZVu+C7IESAhyl2ewbmJ07Zw4qKcYzJdvhyrPwxXNBDZPQzwrP0Luw3W7U/ZCu0H2q8UjHEbW4xn9lQMuyRtMejTsniiTCNNjio5ohacylLFu3CsFEMBucIS97s0mLK7CVUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524146; c=relaxed/simple;
	bh=qSm0alfl5BI5F+EUqVMRslKei9mFJ679Do3KWYLs6MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyHlDytcvv+OzBO9ce9i0oxIZHuoCaoq7/Lg31r7y4yzssmdhAHui61WH7jUJWyQbIdNMoZ+q9ddZdC2+Alj1mWpR1xvzNd/NNgtaCs5h3FK6gTBR7ihntsE8CATFyLGWxaLr2twKT+zVrO/eR0LiU8euOtrbmAdAq+Ga/5hZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrHSWp8P; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrHSWp8P"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc305914so4930793f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769524143; x=1770128943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RzsSYm6I8uueV/iFR6SlAY5cx6+4mIHkGt73AMjJd/E=;
        b=VrHSWp8PgNWNokYHwoI4AIIZH9hza5XpURCRTZNbCXuXVBc/DJKboqdXb/7q6gbvv8
         MC/RJwHg4k449Ks4YbCvox8sALQ6IfhjHLWJBz/AiFbj1Coc8k43qxm/I+jku9q0oIZ8
         lpeoSXJQHoTZD+D5UllwFFoLfUaRNpXjXTimSZ5CH1sineNNSeXnLw3fghPW98tVJhgZ
         b8WvmdMbmiuGIa7DKbwF+gIKCKknd+3HokJ1B2WrZXzcU6gfhG76Lm411xF6MYm6rMWK
         8rcCHoDmxJRhlCzeIBI3+b3IgxQZZMDrGod8YENGARCAbM9m8tK8dZHCZqWdN/FpHUs2
         BnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524143; x=1770128943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzsSYm6I8uueV/iFR6SlAY5cx6+4mIHkGt73AMjJd/E=;
        b=hQy3COZL0swyEq57nAd63Mz6Gjk0T41ZRGgFITvA+ziqnpzHX9NvIzNAvPjdkr5HeO
         aRPOqD5rk8h8c9/ehTlkznUvapSeXCXY4XA14w+zuJaUue1GBUAErdDwwVXHpy0Elc34
         St/S4QZ8hhOqMO8qvJfOJfugJ7j1NdtzjCuier/RvqivWiSlvyh+C4+BMr9JZfKNd6B4
         CvxyNFAk4XeyJiaUHh993LnI6IQoaS8ILlg2gyacwUZikmWBChXdVtOcHjHqRrepqMhv
         IMHpvB9xLOcDSA/uYXdJgusLbO/6fRrT1OeV86+P5dW3V5K3PVJdm/Arcx8UWN1APXY7
         dJpg==
X-Forwarded-Encrypted: i=1; AJvYcCUkkS2+78A8XwgW8VzrRRDug/sehjnrcOD7C9G0Elud+Y3RL8+3xUqpS/qFNPLzCE4jT0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysq8fbOAVxV02KIrWEcKO2n2Gd50qcJNIuCCC/yduAIqh7jgsN
	Mrqrr8SYnM069M65uHX1YdSclNDy573QgUwBCkqm3QalczSrYEAIYNgn
X-Gm-Gg: AZuq6aKX8k9HanoFxWWp29PERlkR7r1QSx6oB3gox88FeyMNWDHaant1D5LrRh6Q2n3
	FdmC1aMJYo8S74PmzjObfwVTetTxei2s0OjD0Xa+qb8pBMl1rSiq/eWSIEDXpmuOI5kovt3gGsk
	emuzsR4ighMzRgq5EM9qmGYBjimtw7BBywJ7Od1y0aMRVcFOav6qYqjjMGZwkxXz99WfxeS5sWM
	wvufJMG2ms+rluaAfFWDkEWyzY7My13AnG0ROG928TIx3lQnEXLgZBfDpSYJqTLA8f1r+oEyPvW
	G4yS491N/B9FCXV5Uq1PkF2R2PRp23ruXuHWGwqxb+Th4ABv1P8T/H/X2mfDJzCN2pQDsHCFGPf
	B3Ab+7ky2nFF9djt6rVgNIcSz/A0cQAmuKpi6qbguNONhXBWDFF2BK1pVuXNanuLFfIWvJRMxB2
	8ruoDoJJUgJhgfZ9adhAj8fWUQB3SGF+IKLeFv3gJstzYZbdrpOv9ywDQY1aM=
X-Received: by 2002:a05:6000:2082:b0:435:a9c9:159 with SMTP id ffacd0b85a97d-435dd05aba3mr2633501f8f.18.1769524142351;
        Tue, 27 Jan 2026 06:29:02 -0800 (PST)
Received: from f (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm37600235f8f.2.2026.01.27.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 06:29:01 -0800 (PST)
Date: Tue, 27 Jan 2026 15:28:53 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 18/22] slab: refill sheaves from all nodes
Message-ID: <cburjqy3r73ojiaathpxwayvq7up263m3lvrikicrkkybdj2iz@vefohvamiqr4>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-18-041323d506f7@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123-sheaves-for-all-v4-18-041323d506f7@suse.cz>

On Fri, Jan 23, 2026 at 07:52:56AM +0100, Vlastimil Babka wrote:
> __refill_objects() currently only attempts to get partial slabs from the
> local node and then allocates new slab(s). Expand it to trying also
> other nodes while observing the remote node defrag ratio, similarly to
> get_any_partial().
> 
> This will prevent allocating new slabs on a node while other nodes have
> many free slabs. It does mean sheaves will contain non-local objects in
> that case. Allocations that care about specific node will still be
> served appropriately, but might get a slowpath allocation.

While I can agree pulling memory from other nodes is necessary in some
cases, I believe the patch as proposed is way too agressive and the
commit message does not justify it.

Interestingly there were already reports concerning this, for example:
https://lore.kernel.org/oe-lkp/202601132136.77efd6d7-lkp@intel.com/T/#u

quoting:
* [vbabka:b4/sheaves-for-all-rebased] [slab]  aa8fdb9e25: will-it-scale.per_process_ops 46.5% regression

The system at hand has merely 2 nodes and it already got:

         %stddev     %change         %stddev
             \          |                \  
      7274 ± 13%     -27.0%       5310 ± 16%  perf-c2c.DRAM.local
      1458 ± 14%    +272.3%       5431 ± 10%  perf-c2c.DRAM.remote
     77502 ±  9%     -58.6%      32066 ± 11%  perf-c2c.HITM.local
    150.83 ± 12%   +2150.3%       3394 ± 12%  perf-c2c.HITM.remote
     77653 ±  9%     -54.3%      35460 ± 10%  perf-c2c.HITM.total

As in a significant increase in traffic.

Things have to be way worse on systems with 4 and more nodes.

This is not a microbenchmark-specific problem either -- any cache miss
on memory allocated like that induces interconnect traffic. That's a
real slowdown in real workloads.

Admittedly I don't know what the policy is at the moment, it may be
things already suck.

A basic test for sanity is this: suppose you have a process whose all
threads are bound to one node. absent memory shortage in the local
node and allocations which somehow explicitly request a different node,
is it going to get local memory from kmalloc et al?

To my understanding with the patch at hand the answer is no.

Then not only this particular process is penalized for its lifetime, but
everything else is penalized on top -- even ignoring straight up penalty
for interconnect traffic, there is only so much it can handle to begin
with.

Readily usable slabs in other nodes should be of no significance as long
as there are enough resources locally.

If you are looking to reduce total memory usage, I would instead check
how things work out for resuing the same backing pages for differently
sizes objects (I mean is it even implemented?) and would investigate if
additional kmalloc slab sizes would help -- there are power-of-2 jumps
all the way to 8k. Chances are decent sizes like 384 and 768 bytes would
in fact drop real memory requirement.

iow, I think this patch should be dropped at least for the time being
