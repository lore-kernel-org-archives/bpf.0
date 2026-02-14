Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2D221F1F
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771046750; cv=none; b=HH2bmY1mCCrW5OFs8UI71ttpcKIzaKG/X4+PcSezVcNvA6L8W1JkrDKfgFRLxCLYx2X6QloGF5qkLVN4q9+XMiuZ+64Fo6B7mG4WKgINCS6b3NLOu6tPkb+RBy5pwlfGWmgt7n6pNv2BOG5iy4D60C5tQ2eEUQZZJEbu7Ng4qlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771046750; c=relaxed/simple;
	bh=wcUoxwPfT1Uw/weaHYkjd+h6xf8NBJfe451UDd3hvSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aokX3skjpHxPWAjIojIngUIHkxDd2OWLH4DgnrOV5s2hgIgO8n8/fkU0m3Iuwx83njEi6wp8gP3twuV3zt8sXHELPBrPKJumIapuWp1BxXfvU2WfWOGtO05d7Cpt20MAWqeTUkmgwiZ0RV+A7757f0u6BUu8BOr1HPms3STrMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xY4F8Zkn; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xY4F8Zkn"
Message-ID: <a1655fee-4ed8-41bd-ab48-cf22db76c586@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771046737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wcUoxwPfT1Uw/weaHYkjd+h6xf8NBJfe451UDd3hvSU=;
	b=xY4F8ZknEXem5unamh0KOuxDLkw1wkSioBIZexZ/T88NdgdXwVfMel1ATrdwtCE3l/JY/C
	OywGd7awdq058fUUJBOGqgT6HJIKSXrydkCPcPM499I7dRHhjDpy6M5ewIF1nufKFL6enG
	9/KHzf+q4izG2PeJmX7mugWe7TZIDhk=
Date: Fri, 13 Feb 2026 21:25:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 1/1] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
Content-Language: en-GB
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260212152013.17351-1-varunrmallya@gmail.com>
 <20260212152013.17351-2-varunrmallya@gmail.com>
 <82d31503-24d8-45b8-b1dd-2cb35bd28509@linux.dev> <aY9dxEBCvurRfzJU@roxy>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aY9dxEBCvurRfzJU@roxy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/13/26 9:22 AM, Varun R Mallya wrote:
> On Thu, Feb 12, 2026 at 04:06:22PM -0800, Yonghong Song wrote:
>>
>> On 2/12/26 7:20 AM, Varun R Mallya wrote:
>>> This patch modifies libbpf to automatically "upgrade" standard
>>> SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
>>> infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
>>> supports it, making them compatible with BPF tokens.
>>>
>>> To maintain backward compatibility and handle rare cases where singular
>>> uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single")
>>> section types are introduced. These force libbpf to use the legacy
>>> perf_event_open() attachment path.
>> Maybe you can have bpf programs for both uprobe/uretprobe
>> and uprobe.multi/uretprobe.multi?
>>
>> You can add "?" before the section name (e.g., SEC("?uprobe") so you can
>> selectively enable those programs before loading. This one if one choice
>> e.g. uprobe/uretprobe is not working, you can then try
>> uprobe.multi/uretprobe.multi.
> This is a good idea, but isn't making the upgradation built-in a better
> choice ?
> This way, anyone writing the program does not have to rewrite
> the same thing twice, keeping their programs pretty clean. This also
> moves the upgradation logic (which is probably going to be repeated multiple times)
> into the library which makes it easier for anyone to have something BPF
> Token compatible without having to write all this extra logic. Since "uprobe.multi"
> is compatible with "uprobe", I don't think anything will break as well.
> (The current breakages in the selftests are due to the patch being in
> nascent stages and I'll fix it after I get some feedback on my
> questions.)

I still feel this is a hack, esp. for libbpf. The libbpf provides various
APIs as the building block. Automatic upgrading inside libbpf does not
sound right. These upgrading thing should happen in applications.

 From bpf program side, you can have progs for both uprobe and uprobe_multi.
You can have static function which can be used for both uprobe and uprobe_multi.
It should not be hard. Looks at bpf selftest, there are quite some programs
with prefix "?" which gives application a choice whether it should be
enabled or not during to kernel probing or other things.

