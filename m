Received: from mta1.migadu.com (out-159.mta1.migadu.com [95.215.58.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637823D75A9
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651713; cv=none; b=sxHQyjp9/BpGJ1U5LFqfYwKmbY+SwfW0jP1O57121uogThWYx85L01Ux9P3xTd8pLwH7Uci5JkJ/J6kJf0LnpkD+4j9SV2vUb17ZUuh+JjrpJH7ikvmqS1hHOSN/9MGkqHrxcERB5siqYEKrufWELTfk7g8ZwXJaw7ygyqSLGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651713; c=relaxed/simple;
	bh=QgozdLzkQn2pf7kO2XhgBfgb8RUxd3/dV0lc3dEGAcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzrXvqicBwkY9SbHGVysN+Ea08gEtu/Tlm6xOxAARSjcVycmKnxJsBUyJUl4WDlnyvmmHpHvwBz5wiuWibpGLbhRy5BECMAtv50IiceFKq2JaC95PCbXgiX6RgS45A45Wmka4XNnmvEtp1fTSmuHJfe8XZQC1kRIx+fDdxTsuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IjUxvHFK; arc=none smtp.client-ip=95.215.58.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IjUxvHFK"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QgozdLzkQn2pf7kO2XhgBfgb8RUxd3/dV0lc3dEGAcU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787651709; v=1; x=1788256509;
 b=IjUxvHFKqShmK9BymD9nc+yOENL3QbqmfimpPP9dsh3JLoFKEE+sLZ09CzlsI93LYf5ineem
 aUNZ17CfMbpnborjBebmWz0/rOHXubipIZ8xWflRh1lxeEUGyAkN/8ATDBWjQQxlkw2YplWbgaz
 icCn54az13XpA7b53/fjjykw=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.25.56] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id 239bdbcf18b51f74;
	Tue, 25 Aug 2026 09:55:08 +0000
X-Mizu-Trace-ID: 239bdbcf18b51f74
X-Migadu-Flow: FLOW_OUT
Message-ID: <95517552-a0aa-430a-807c-be3299e33dcf@linux.dev>
Date: Tue, 25 Aug 2026 17:55:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 0/4] bpf: arena: handle memory.max on fault-in
 with reclaim/OOM
To: Khawar Ahemad <ahemadkhawar123@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, jiayuan.chen@linux.dev,
 emil@etsalapatis.com
References: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/25/26 5:49 PM, Khawar Ahemad wrote:
> This series fixes an issue where accessing a valid BPF arena page under
> memory pressure (hitting a cgroup's memory.max limit) incorrectly results
> in a SIGSEGV crash instead of invoking memory reclaim or the memcg OOM
> killer.
>
> Problem:


Hi Khawar,

Just curious — is there a reason you're sending the same patchset 
multiple times? It will cause flooding on the list.

