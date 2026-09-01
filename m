Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9584344D8C;
	Tue,  1 Sep 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248144; cv=none; b=ay4y9BDt6c1bvBdIFFdMnff03HslfyUxlJqQ30NPpVCeby7NiQAETLkjnPMhAzUjYq6gJciNmFR8Xhoumg1iBslj7OYPeHm/qCnWjmNRyQH/LXbOI7M+176ZrfDWzPcNQANli+d0D4Llql8dgDlNZ/cbvEgMKHDnPoRbSU0RLWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248144; c=relaxed/simple;
	bh=M/KE5rcbD85EtiQ7TZsfyWN8T5K1p+1XQNTInOeNLL8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AH5JQ29pV3Bp5PulunW/rluK1k1RQISeO/kCJbN5Cvt0u8fu7R+aQoFbhTIPmdTttCxuuiFIkFy+lpVCwkjrYz35wPsvSLjK/jARDmm7LeyR7ZSSqR2t3XIfOg7xAvTO2CRfFSJIMLcC4fKnmHn7Ny23AODJktb1nloQn3oVHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=kI65ibvX; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="kI65ibvX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kGm16IxYb54a3zID3qH4N1aAfIiUxF4X75orXCP9VY0=; b=kI65ibvXCfjK0FNjyf6jQrJqqn
	eRQUiDDQnP2gdjPRDtj76NLWV+lj+cL4n3p33kUIAVKQTbxA+42cv+qXUVcPjnSwcXGE8zbqAEspO
	hkXC5VubnoKiWdfsd7A5Cr4jdFHcMcIhqIhTl3rx5sufwVdrVekesdqWImbjYfwI13YaEO4/5Hqm8
	ShLSHjzwd0auIFSi2Ve1kzO3NFazCqh0Qvtrw9AYyF2L12QlM06V5HjfqxpUkTPf7+/8b9vCzmqVT
	jJOH22538wydH2Pmy1PC9poWQHgc/C2yBpmHpXkozNEGlQoupZJua6wPCpB0GdViWZnrHmcAxFdSe
	oqC3veMg==;
Received: from [::1] (port=51530 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1x1IeI-0000000CHJP-0UkU;
	Tue, 01 Sep 2026 09:11:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Sep 2026 09:11:13 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, rlmenge@gmail.com, hargar@microsoft.com,
 apais@microsoft.com
Subject: Re: [BUG] bpf: x86 timed may_goto corrupts private-stack JIT state
In-Reply-To: <CAE5sdEiGA+chRkkNGOWL89AFDNXor1RKHMEmouCNoCXVd4fc-g@mail.gmail.com>
References: <20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DKYH3KM93BDY.1MR4WLZSWGEU8@gmail.com>
 <CAE5sdEiGA+chRkkNGOWL89AFDNXor1RKHMEmouCNoCXVd4fc-g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <d4e2ae332a9505cc2cee5a236ff86efb@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-09-01 00:57, Siddharth Chintamaneni wrote:
> On Tue, 25 Aug 2026 at 18:10, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> 
>> On Mon Aug 24, 2026 at 2:31 PM PDT, Jérémy Jean wrote:
>> > Hello,
>> >
>> > With the help of AI models, I found a bug in the x86 timed may_goto path that
>> > leads to a verifier/JIT state mismatch on private-stack programs.
>> >
>> > The root cause is that timed may_goto fixups pass a stack offset in BPF_REG_AX
>> > and the x86 trampoline reconstructs the counter pointer from native %rbp. That
>> > is incorrect once private-stack JIT mode is enabled: ordinary BPF frame pointer
>> > accesses are remapped from %rbp to %r9, but arch_bpf_timed_may_goto() still
>> > uses %rbp and ends up reading and writing the native JIT frame instead of the
>> > private BPF stack.
>> >
>> > The bug was introduced by 2fb761823ead ("bpf, x86: Add x86 JIT support for timed
>> > may_goto"). I reproduced it on a KASAN-enabled x86_64 kernel based on v7.2,
>> > however KASAN does not trigger because the bad write stays inside the native
>> > JIT frame. Yet, the saved-register corruption is observable.
>> >
>> > I have not included a patch here because the fix seems subtle to me and would
>> > likely touch many files for different arch.
>> >
>> > I can share the minimal reproducer and other details privately with maintainers
>> > if useful.
>> 
>> Just send a fix and a selftest to the list.
>> 
> 
> Jeremy,
> 
> I just wanted to check whether you're working on a patch for this. if
> not, I'd be happy to take a look.

Hello,

No, not at the moment.
Feel free to ask if I can be of some help

Regards,
Jérémy
