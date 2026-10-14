Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E40411A10
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952783; cv=none; b=PWBfd8YtRgYUOs/db+024Czyjj/NXfGg/OFRCbYb2Q4FPDBCo4Ysie4Qpplu+HNjBYxpUoVkvWknO4lYGzTmeZN+6r8w7zigZaRwSRuMGMfPZMQWU5NjZ63uoyqrDaWh4LoVrq9KI6oE5i3d/mMHoyTrJ8W33UUGgSMWHxTpgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952783; c=relaxed/simple;
	bh=DZaRy/akjBHf9ZrR0eHy04lM1SxePYwM0arX+/4ffzc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iaGYFF9/9o62ESlSw8BnbmWs8iExyTT1bj6iexa79dQUMEkrzwx21lC58drNFgwyX0m2D60/Z14Gbznj12ZZxCGsykV4dl2aVkQtyF0P0CU6hRh4Oe0F7J0plcTehkTzWZhpSomP2dmsjoeltIQbjBwzHhQWhh6AR8WjNuvKQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve4t7EcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve4t7EcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA5E1F000FF;
	Wed, 14 Oct 2026 04:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791952782;
	bh=mVKkCeEdC/Z3bV5+Gj0QiuZvl6B9f0qk36QBoeLCgSw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Ve4t7EcLOnzBpcI1YE0/Db/F1QU0KCzu8pjxRHF19QIufyy4I3/TRuZaq2ELtAzt8
	 GfCAB2fUjoONolJxsJ+1F5Gtmz0yztKMOjHTgqRemlHuHrDMOiP6643ZSBx9Py0qKX
	 O+scu1BR6iCqPztQz8QgwjTKpjqpujy+oP1cEYzwLs/JsaLqn7BUQLB5uySXTeAV1f
	 chdAoBd+fqN/fzxdM8rj03xEtKaPpdOfp2t9FcPXZQCp66QID+/PPriT1uvpBACUUN
	 TdpNc4ZBMqm4ECzgu02nuEkuWyCDzqOEkIiM1BjJ6USZqmmDag+xwBGdLIcsBQ0hH8
	 DUl1YN7tuCGDg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 07529198003A;
	Wed, 14 Oct 2026 00:39:39 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Wed, 14 Oct 2026 00:39:39 -0400
X-ME-Sender: <xms:hwfPagdIJmelWczr7He8n9KRTjGUR-fo9YTa5G_szGq2dn-OK-yeFA>
    <xme:hwfPatDIBaRejOSh-km9hQyHvEnn1xC9sD9FZ06z2kHkmj4sDtwTBA92ZqbCeHJn8
    8zpS7vEzfaCjp4EHJzyhiFPHzewKvVa_xA0KqmYjn5DudIBukDn34eY>
X-ME-Proxy-Cause: dmFkZTE6pBDUsJEPr0X2GlKwrjjE+OE5kUEHvpuPEEl0/V6y+5kxMhe+G35Lr3HmkzZN1n
    1lFFtYXYC2zAIFzuXWsk+8iOHgzKsSLuzGH5cnMle49tSzmY4aUJkM5eZBDt2pkFqtSNJC
    TpsJbwj5DMMioB4ofwJ5JZYJg7X5HLdDvwP6S8efsLSiaRJXVavguBZeGE4D1OAqIV6XKo
    mVTi3yjX66ip85F6m8Tzbz7LN/y5SOftKGYu2319JkGv8n4sficapx7VyFzw+UBQ+didy6
    vhAXhECdzhApuikAv5Oh9j0j3YjzEhe36ocpkiExpU21r90LwjF6Wzj+4VCwfDn5BqJFFK
    JND3vloSJzRw+u3SkcdjK8yHAjYo+fbUy5Ho4F8OP1HP4z+jHQDr8lYZJrygElaGQm05SK
    JuR5z4C/W44eMwOAFQyyTY2COeXVQDRyt+pxPROFg6V+By4LaEhKQ/KP69wafWMQ1qRc3K
    nZw0hP0JA68yPYYC/zkwYkpYedjazidjAxmf282AYUKVVUoadYes5U34DDJwN3fYTWVQ76
    VDYxc1JP8EzGqR9ICTjhoIbcV0WUPX7bAyjWmGz3xHJ5lSUoueeztvQKWxL6d0yAvoDLip
    HXB3K9f0nPH1ZCiqUUxpq7dOobhlQG8zN6ankyBF/K04OKkt81SMVwfXaj8w
X-ME-Proxy: <xmx:igfPatadCwlNeP-f7qFvfF2T21Y-b5awskS_Q9cwafrJNmbL13TdGA>
    <xmx:igfPavaI5NBgoPWMt7PTB__VRt23F7eLY4Ng9ebzf0FACZLh_Mv4ZA>
    <xmx:igfPammn66nNiMEmtdjxGJGTXyh82YjU4f22HRaxAF3s5ypjKV_GbQ>
    <xmx:igfPapSv03MzL7AkAKMPLEHBu1nwNc9kSB4a8SBCWaMqh1ortoprdQ>
    <xmx:igfPajXgQQXszY5jntE4jDgiT2r-VHw3AdfJRA8CgBi4yq1sXz3Rb_Di>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 23539F8008E; Wed, 14 Oct 2026 00:39:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 06:39:14 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Mark Rutland" <mark.rutland@arm.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Jeremy Linton" <jeremy.linton@arm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Vitaly Kuznetsov" <vkuznets@redhat.com>, "Philipp Rudo" <prudo@redhat.com>,
 "Viktor Malik" <vmalik@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Andrew Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <8fb05f13-e770-41a4-af66-d239b4c95201@app.fastmail.com>
In-Reply-To: <20261014000227.GV13920@nvidia.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
 <20261014000227.GV13920@nvidia.com>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE format
 boot image
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(removed some bouncing cc'ees)

On Wed, 14 Oct 2026, at 02:02, Jason Gunthorpe wrote:
> On Tue, Oct 13, 2026 at 09:19:28PM +0200, Ard Biesheuvel wrote:
>> > Given those constraints entering the successor kernel through the
>> > normal EFI entry point is highly desirable. This would allow x86 to
>> > continue to provide the DRTM trampolines through an EFI mechanism and
>> > means the Linux EFI stub always handles the launch with identical code
>> > in all scenarios.
>> 
>> With some help from my friend Claude, I've prepared a prototype that
>> reuses my efiloader Rust crate to boot EFI stub images (bare Image,
>> zboot, UKI) in the kernel: the EFI boot phase is invoked at kexec
>> load time, and runs under the preceding kernel up until the point
>> where ExitBootServices() is called. Then, the actual kexec call
>> will return from ExitBootServices() after shutting down the first
>> kernel.
>
> Running it inside a kthread is such a novel idea, I would have never
> thought to attempt that!
>
> I've asked some folks here to take a look and try to test this with
> real DRTM capable HW. It seems very promising that it will work to me,
> and I surmize this is also close to boot a UKI?
>

It already works for UKIs as well.

The next step is to run it deprivileged - I think the arm64 stub code
is already very close to being runnable in that manner.

