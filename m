Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97AF25B0BC
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102168; cv=none; b=rgH3P3fyixioUDUmr7idO9zwzdXE3PRUkoN3C6Ag54lVWIcQPy/rheJpgFhbkXaijALNzSGvZ10OXOMfGTmrdcuhwwiclgQVtvsAcYPwE+IU1QLCKC0gEXa1nxG/t3JH21bPQOUSz3VriauJXJbJmUBCIVw/XV/rWWAfbJhjdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102168; c=relaxed/simple;
	bh=+rdTtWdFXQ9KMu/JF0Y0thBqgRjRKieZuXov9YnpNWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F6k2atNkPVspvaAYlkyMJg60PF62exv3UNw6Jgtc6LekLlrN6Yh6ijr/DHplq5HS11dzy+lxYnLVEcqJouoG9t9GVAbL2hPEv3FnyENSdFSmzaIIWZ9DNgueHOoJA2MkVEmtqK6aOHdUINqxYky/MQlfgs2n7IJIJF6hxz7w2xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdiOJ/GB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdiOJ/GB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4211F00898;
	Sat, 30 May 2026 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102167;
	bh=jenHuXcaZAT4qvDkovDVzDfAFJNuFpAlR6GEHkclCKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BdiOJ/GBa5IaPAn0RaJ82hTFoYyi7JnOdSFvR5ktXawDEsBuPnZMi1w7QiS6w9IUV
	 f70HfVL+7YKR/BXvu3w6AeSZXgi1b6x6V/iCCmhYvpLife6LaTlPbBMUkuY1SB8uas
	 gdGKyPpu5qYZG1yhLcP1eXkwjOlMP33stQtyssv8jNM53vD+gRCEdcAMQIHibC2Xu9
	 kdwqlaMB1bATLLWudDK8FfBQSjNSmD82xIR6NbMLZW/nPW88d0DKIA4NhdopQ1KhS6
	 VmnXtXl2nfSXWa+IOwmuq/YIok8qV2OR3G/jU/DyZqVpsez1yrM9oiBoCi4W7QlAsT
	 wfhlimLo6mRTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] bpf: sockmap: fix tail fragment offset in
 bpf_msg_push_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <n05ec@lzu.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>
References: <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:49:27 +0000
Message-Id: <20260530004927.7C4211F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_msg_push_data allocates memory for new message data withou=
t the __GFP_ZERO flag, leaving the newly inserted bytes uninitialized and e=
xposing kernel heap memory.
- [High] When appending data to a full or nearly full sk_msg, bpf_msg_push_=
data incorrectly reads the length from the inactive msg->sg.end index, bypa=
ssing the coalescing logic and causing a ring buffer wrap-around, out-of-bo=
unds access, or information leak.
- [High] Calling bpf_msg_push_data on an empty sk_msg causes the scatterlis=
t iteration loop to traverse inactive ring buffer slots, leading to ring bu=
ffer corruption.
- [High] Shifting scatterlist elements in bpf_msg_push_data and bpf_msg_pop=
_data does not properly shift the msg->sg.copy bitmap, breaking the Copy-On=
-Write mechanism.
- [High] The len parameter in bpf_msg_push_data is not bounds-checked, allo=
wing a maliciously large len to cause an integer overflow, resulting in a s=
mall allocation followed by a massive heap out-of-bounds write.
--

commit fefea84ac268cf25e699730bfbde310ae44b83f8
Author: Yuqi Xu <xuyq21@lenovo.com>

bpf: sockmap: fix tail fragment offset in bpf_msg_push_data

When bpf_msg_push_data() inserts data in the middle of a scatterlist
entry, it splits the original entry into a left fragment and a right
fragment. The right fragment offset is advanced with the message-global
insertion point, which over-advances the offset. This commit advances
the offset by the fragment-local delta instead.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..80439767e0eea 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2869,7 +2869,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,

[Severity: High]
This isn't a bug introduced by this patch, but when appending data to a full
or nearly full sk_msg, does bpf_msg_push_data incorrectly read the length
from the inactive msg->sg.end index?

If a BPF program appends data to the end of a message, the search loop
terminates with i =3D=3D msg->sg.end. If the ring buffer is full (space =3D=
=3D 0),
copy =3D msg->sg.data[i].length reads from the inactive slot.

If the stale length is 0, the if (copy) block is skipped. The function then
calls sk_msg_iter_next(msg, end) on a full ring buffer, wrapping msg->sg.end
to equal msg->sg.start, logically emptying the message and leaking all
original pages.

If the stale length is non-zero, it sizes the new allocation incorrectly. If
the previous element's length exceeds the size of the allocation order for
copy + len, the subsequent memcpy will overflow the allocated heap buffer.

[Severity: High]
This is a pre-existing issue, but can calling bpf_msg_push_data on an empty
sk_msg cause the scatterlist iteration loop to traverse inactive ring buffer
slots?

If the message is completely empty (e.g., drained via bpf_msg_pop_data),
msg->sg.start =3D=3D msg->sg.end.

The do { ... } while (i !=3D msg->sg.end) loop executes at least once becau=
se
of the do-while construct. It traverses uninitialized or stale elements,
accumulating stale length values into offset.

If the loop condition start < offset + l fails to break, it iterates through
the entire ring buffer, leaving offset heavily corrupted. This leads to
front =3D start - offset becoming a large negative number, causing a massive
out-of-bounds memcpy that will reliably panic the kernel.

[Severity: High]
This isn't a bug introduced by this patch, but could shifting scatterlist
elements in bpf_msg_push_data and bpf_msg_pop_data fail to properly shift
the msg->sg.copy bitmap, breaking the Copy-On-Write mechanism?

msg->sg.copy is a bitmap used to track which scatterlist elements are shared
(e.g., from TCP zerocopy) and require a private copy before modification.

When elements are shifted in the ring buffer during bpf_msg_push_data
(shifted right) or bpf_msg_pop_data (shifted left), their corresponding
msg->sg.copy bits are not shifted.

This desynchronization clears the copy protection for elements that moved.
A BPF program calling bpf_msg_pull_data on these elements will be granted
direct write access instead of triggering a copy, allowing it to corrupt
shared memory or page-cache data.

[Severity: Critical]
This is a pre-existing issue, but is bpf_msg_push_data allocating memory
for new message data without the __GFP_ZERO flag?

bpf_msg_push_data allocates new pages via alloc_pages(__GFP_NOWARN |
GFP_ATOMIC | __GFP_COMP, ...). The kernel inserts len bytes into the page
but never initializes this specific region.

A BPF program can request this memory expansion without writing any data to
it. If the sk_msg is subsequently transmitted over a network socket, the
uninitialized kernel heap memory will be sent across the network, leading
to a significant information leak.

[Severity: High]
This isn't a bug introduced by this patch, but is the len parameter in
bpf_msg_push_data missing a bounds check?

The len parameter is a u32 value passed from the BPF program, with no
verifier bounds check (ARG_ANYTHING). An excessively large len
(e.g., 0xFFFFFFFF) causes the 32-bit addition copy + len to overflow to a
small value.

alloc_pages successfully allocates a small buffer. During the fallback copy
logic, the pointer arithmetic to =3D raw + front + len expands the 32-bit l=
en
to a 64-bit unsigned offset, advancing the destination pointer by ~4GB.

The subsequent memcpy(to, from, back) performs an out-of-bounds write on
the heap, allowing a verified BPF program to corrupt kernel memory and cause
a kernel panic.

> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;
> -		rsge.offset +=3D start;
> +		rsge.offset +=3D start - offset;
> =20
>  		sk_msg_iter_var_next(i);
>  		sg_unmark_end(psge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8b129d10566aa3eb43f=
61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com?part=3D1
