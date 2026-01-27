Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D532571C7
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547720; cv=none; b=jHlzEIonKOVPbbKOwvLQIKKH39+pNf0/MyXGf6BiirDbzHhDnZd8HVkB94O0s5jT4DiwR0Bsd9OmTAvxEMWA0ie5hHEcaApOQVYePSJdYcNeFx/61tlxTwGS9C2ijCy0qDVk1jcCXrhC7tvDmMxsEuqSCTlIIj2tHJs8AkIVCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547720; c=relaxed/simple;
	bh=UYCQqo5QuCqVm9o3OpNSE5lns+ZSOVZPjyTQm+BpAGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mc2aaUpez5voyF90SwmPlxzpj9shUZKZLz8McNatPh2m0gp/2woeSUYjrhoUWPTjzPH93HyEFWk7FbIsDN5mm3XSFikXHabTPBfuy3fMdRzrt2ac74v0HTjYrHh0uqtc7oNiXWsD4b+Q6hUb5s3BTcRnVvNymAgQbbTYW0W6w3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mKU2mvz2; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mKU2mvz2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769547716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs/VTqhwxiApM2k3Iv0n6ahnPBiWdzK/0rcCymF+C0A=;
	b=mKU2mvz2oA6LgTfovx/gJTIul263fAsC+yNOGHHMBlWg3/zzkH0PPrmIJ/wP8MF74009oT
	fEpfWCgNi6DXEEN/LCOSn6/viAN8tERCR30BvpgYVgxjvSCNY+2G5aqhMf4u/nBb/AzA5A
	JiCOao6zDMfCIvQsviU1KaVGidwtbBk=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Matt
 Bobrowski <mattbobrowski@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
In-Reply-To: <aXh_LpTzDhvv20uB@tiehlicka> (Michal Hocko's message of "Tue, 27
	Jan 2026 10:02:38 +0100")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<aXh_LpTzDhvv20uB@tiehlicka>
Date: Tue, 27 Jan 2026 21:01:48 +0000
Message-ID: <7ia44io6kbwj.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 26-01-26 18:44:03, Roman Gushchin wrote:
>> This patchset adds an ability to customize the out of memory
>> handling using bpf.
>> 
>> It focuses on two parts:
>> 1) OOM handling policy,
>> 2) PSI-based OOM invocation.
>> 
>> The idea to use bpf for customizing the OOM handling is not new, but
>> unlike the previous proposal [1], which augmented the existing task
>> ranking policy, this one tries to be as generic as possible and
>> leverage the full power of the modern bpf.
>> 
>> It provides a generic interface which is called before the existing OOM
>> killer code and allows implementing any policy, e.g. picking a victim
>> task or memory cgroup or potentially even releasing memory in other
>> ways, e.g. deleting tmpfs files (the last one might require some
>> additional but relatively simple changes).
>
> Are you planning to write any highlevel documentation on how to use the
> existing infrastructure to implement proper/correct OOM handlers with
> these generic interfaces?

What do you expect from such a document, can you, please, elaborate?
I'm asking because the main promise of bpf is to provide some sort
of a safe playground, so anyone can experiment with writing their
bpf implementations (like sched_ext schedulers or bpf oom policies)
with minimum risk. Yes, it might work sub-optimally and kill too many
tasks, but it won't crash or deadlock the system.
So in way I don't want to prescribe the "right way" of writing
oom handler, but it totally makes sense to provide an example.

As of now the best way to get an example of a bpf handler is to look
into the commit "[PATCH bpf-next v3 12/17] bpf: selftests: BPF OOM
struct ops test".

Another viable idea (also suggested by Andrew Morton) is to develop
a production ready memcg-aware OOM killer in BPF, put the source code
into the kernel tree and make it loadable by default (obviously under a
config option). Myself or one of my colleagues will try to explore it a
bit later: the tricky part is this by-default loading because there are
no existing precedents.

Thanks!
