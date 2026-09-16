Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37F403135
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586419; cv=none; b=fRKGd5l6vAtTWMlOyEvRxih//heYBCeVlRwg1GJHCSIADtjsbp8Y5QG2xuqqiiOoWF7E6VkPI5x4v2g/OnSAUzE/vnqkoQC6bH5EAoCgXDAA4c9B1ZqjKydVyWTc6nNrg3iywx0prJCeQQN9qALhEzKuzl3wOev2zi8/iIRJs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586419; c=relaxed/simple;
	bh=+fX6hn9Fwk2Hi4VU7b4QUmvNykXbA3KCv1YsVHX+IP8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ldN4wZLNEVY92cyTrVTtmFJSCFcDpgyrrEbVRwqvCDORbcuVKn1qujl3YdmJ4fp2hmS9D/5vf0Ir5GbYcqKtAW/iaiKkMkj3P4oBqJ+PO+Ua4joQaf+t52I/59T2ZCPZjaanQaOaDN4wxP3alNiT9AZ9LfJtQ6UIuRTj5uS7HL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYZh0aO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYZh0aO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9D51F00893;
	Wed, 16 Sep 2026 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586404;
	bh=X6BNMaiEntUDUSI8FpQgsBgqOoPaQdzvdhj1rbSSNHQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MYZh0aO2CM4aq6DObcbhT1Du2PFc+CEau3UJCFX/iITZUsvfDsLNa/XOXZs0Gb0KM
	 cyWBjO3IVyVtlXXlqXQqNt3E3yeB9SRp5XcvUv1sTBljgH0IkEArMpaS2M/DLee/Kv
	 xFRqxAapckGhospIycLuJdSdF5Tg97opIaOXhbrH4/i0wgb5acJ1V9xCdrYLy7ZURo
	 wJUaamnidhuf2i3Sr6DICdhV9HKvTDvdrtUqNAovekSaXGRUfs08tHdxjgGBpYLvzz
	 NIPwQ2AomP0BEW+8ouL696zbV4INidNQa5kowvr0Q3e+0KAFs6LEeHtVNvohL57V43
	 kSyGUiFx9fxDQ==
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfauth.stl.internal (Postfix) with ESMTP id 6BFBC780043;
	Wed, 16 Sep 2026 15:20:03 -0400 (EDT)
Received: from stl-imap-13 ([10.204.2.104])
  by stl-compute-04.internal (MEProxy); Wed, 16 Sep 2026 15:20:03 -0400
X-ME-Sender: <xms:4-uqaoxNCb8McMjKdfqxxfc5eBhyv598zrw8oTHvKp-0nG_dyNhRNg>
    <xme:4-uqanGgQHPcxWWYiRZx6CFqItYReejduPBzOy_zMXGY0Wgm8p2A0lb1b1C1SmOl5
    P5FkarYl9R_2R23eJ348PM0irAv_cGdEQuUyS981-VsKATZWohYrMN6>
X-ME-Proxy-Cause: dmFkZTEd7OBjhZcGHVXvhPcL8HjNTmwZ1ex/eogreQiwl3BrQzOPmGyHHxVYIV8ffxfIJ8
    EsBu9Y0MpCC++SgX5uJ4wvIhU6BCoxviDExa6rC7+4K0kZQlv4vOMnhuupvRL2Y5fso4gK
    AP5EaVWQIcld4D0aC18X3e/tV3TSSYECMyu0injKYNx46TZnuLkshCWrN/qq6UgxU8qymw
    RqoNmeVpgg3kM525T6Fsydesft4PY4zRKf53ub1ekYWF6zNigRRmS6ukpeBbISC7gfp3Zg
    oWB+JOByJdIsQZFZ5XaojMNK/TPQ52cWocWlOF9PB43M7B+2oPfsfbbRykuKkCVkt8Y3cH
    zyc4YBSJ1dtuhSP/TqtpAbroaiAVW0twnizAJTz64xLimzckvoRwe++2t9+B0crQ9uT2GR
    G7kda+kJH01H6pwO2fWVzuEX5MKsi5QePdGJnjiiXhiNtj10NrJPbi2fxwgCMhdnvRbG9T
    2f1jDizFeYF7loH6iF1G2htTrEdfn4w3w7rm5/aUFgXZPHLl9xbCSm3ogY6CVoFUPUGtQK
    KoUyxX94JIGTpjjAzIc1qb8yxQoj+Z9hBedketh2TIP81sFrlM3/6H6O+lGDHJOt08tR6z
    hGMXDclgAAZ64vC03FHz3i5uzaphUIvKfsmIR2MFmUcQAhjqwmIBhwKsnBtg
X-ME-Proxy: <xmx:4-uqajrbAHEJqgTZcNz_7-4pOxQEsc0oEFgCS_eTWqWgWtypTysDzw>
    <xmx:4-uqauXhetZjLclqmvbM5Da8-CSjyA-bsY0E0wKbLTeS4OzNhqcLNQ>
    <xmx:4-uqaubAFtZTRrZgikbxuzaD2IVxzYwdevVIeGKFI-vik8s-fYFH4g>
    <xmx:4-uqarclVDMQUxbLZmi3DFa5W_TbwzAj4HgoDS0u0Fb9SddUQ6_c9Q>
    <xmx:4-uqao3URF9A9GOEx-Gp7-tOQQJ0v2FkVacMlHZ1UaxddKjBFJ3jAayg>
Feedback-ID: iccae4b50:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 351ECF60070; Wed, 16 Sep 2026 15:20:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfRW-UvO4SB-
Date: Wed, 16 Sep 2026 15:19:42 -0400
From: "Chris Mason" <mason@kernel.org>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, brauner@kernel.org
Message-Id: <9fa4fb3e-2bb5-4fca-89f6-24b834acd40f@app.fastmail.com>
In-Reply-To: <DLGYPZAL708V.3GFLANAPH2L8O@gmail.com>
References: <20260916183303.3504885-1-mason@kernel.org>
 <20260916183303.3504885-2-mason@kernel.org>
 <DLGYPZAL708V.3GFLANAPH2L8O@gmail.com>
Subject: Re: [PATCH RFC 1/2] bpf: fix UAF via trusted BTF walk after release
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2026, at 2:46 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed Sep 16, 2026 at 8:33 PM CEST, Chris Mason wrote:
>> A BPF program can keep dereferencing a trusted pointer that it loaded
>> from a referenced object after it has released that reference. With a
>> file from bpf_get_task_exe_file(), f->f_inode stays usable after
>> bpf_put_file(), and loads through it read freed or reused inode memory.
>>
>> A pointer derived from a referenced object is only valid while the
>> reference is held. release_reference() enforces that by invalidating
>> every register whose id or parent_id matches the released id. However,
>> check_ptr_to_btf_access() builds the loaded register with
>> mark_btf_ld_reg(), which is not given the source register and zeroes
>> both fields. The verifier state for the f_inode case:
>>
>>     file = bpf_get_task_exe_file(task)   file:  id=N, referenced
>>     inode = file->f_inode                inode: trusted, id=0,
>>                                                 parent_id=0
>>     bpf_put_file(file)                   release_reference(N)
>>                                            skips inode
>>     inode->i_ino                         accepted, unprobed load
>>
>> Reproduced by reading inode->i_ino after bpf_put_file() once the task
>> owning the file had exited and new fds were created.
>>
>> Fix this by recording the source's reference id in the parent_id of a
>> trusted PTR_TO_BTF_ID load. A program that dereferences such a pointer
>> after the release is now rejected with "invalid mem access 'scalar'".
>>
>> Assisted-by: kres
>> Fixes: 57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers")
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> ---
>
> Thanks for the report. I have a fix for this locally in the queue. The diagnosis
> is correct, but there are more places that would require changes. For instance,
> bpf_real_data_inode() should, but does not, propagate the lifetime of the input
> argument to the returned inode. That would require some sort of annotation so
> that we are aware of the lifetime relationship between the input and the
> returned pointer.
>
> I will send it out and will handle this case as well.

Perfect, thank you.

-chris
