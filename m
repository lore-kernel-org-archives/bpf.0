Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457208;
	b=wGbwJ+0Hce/Ywpt2dOmXadr3nMGNGQMTPsX5wV3jBnv0elmm3Z/Y6tFt8YgLo/KIqys7
	 fTu89SCijiPhwj0Sh1ghPGFrr/EALPEgccamyuiphDqp8ExEnB2DoOj058Z+yADc7wdb+
	 JJy9HlH/2JzNlWhsJF93Wrqrp11YdVL/SW9hbNpl1uAXVdw6PXDeXBZdsos25wclZ2iyX
	 tEFyNkP0DOlri1eIDytezeesQIkjPkVrTFK0kohyzoaV4GzRv7B+G9RKegnYSR98nBMqH
	 owtjIe3pYMaqc52aWZ3I9IdO2+jSzmFc1YONbv/qNZvq39wHV4tF1f8abfWf+iG5PIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=A5/owT9FvL3cWMXDgvLY0NCzw6oVKkSNI7f5H0xK3CY=;
	b=OkyFMN3392+Pu6391xanbSxpk/sC7C0+nKc6vYxpFiSs8sn5TJUMQCVy67R/C23MH6Yd
	 J35OfmuW29pVRc3fpjN9gf1I/IcokgW+zoRfMYrIJmxIuUBuNB7TTJCR0SEtmoXJZ2jK9
	 b0Bs7F6A9mVwdz1FuUzMRUAriAGasvpXXPstKI9sLt4MGhec+Xc5b63sn4IGSVbjKHApT
	 OuxujueTcbMyAqvhlxie3BuWGxWH/W0H2WwDnNQ5B+L+QUIjjB799xopg+jMytsKr+Q2U
	 wJEEIxBJu96RqrzMbdrLKPwduvJf/gsM4wBSweKqXZGZe5wPscTIies+n1TC4iTnH9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Zqegy/9C";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDD606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 04:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54DDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zqegy/9C
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed39646f04so14595435ad.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 20:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794457208; x=1795062008; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A5/owT9FvL3cWMXDgvLY0NCzw6oVKkSNI7f5H0xK3CY=;
        b=Zqegy/9CN9h2hD9pOcgkMRkRuCNvf2y7GZiiPL9y5m0N9pX4BmJ0h25SViVnHEb1Jf
         41GjJYsgvx7H84wlGEq7bMn6XWLZTjN4k/Ixn0hGRPxAte3XaSQ4C1yZT278zKJNPVHJ
         r/V/fcIozG5wpmMy2k8MmYBsoLXP1Qias+uieeft1rToVylf1YAqZRvwmprgmgB+/bda
         fvlyBFd53zDSxCjbv86DFL6AfSL23WfIWXN2opq8XEWPOlRvWpktkzATrJ6ra9PZ6oJo
         oyDBuqV9ojr7vhg9N35JWG6sE4+hDp7y+6PxLraMXyWqXplqFtyUMa57aWb3eKFjl9KJ
         OJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794457208; x=1795062008;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5/owT9FvL3cWMXDgvLY0NCzw6oVKkSNI7f5H0xK3CY=;
        b=d6oxpogUik1j5cVWhJI6PEWDR7K5BltXRfPm81pLUXtBaMVbQfJgYM7M90nRPBNdR9
         RoUjXUT0Xh76Jng6QhkKGZ7laqvsGajgV57LTD+dLzPhoXy+O2vj2WBEd+I99A9sJhm7
         O0GAWhopkNjmrXjlXDOmNJrD6kH1/rEQ0lW38i8xx+YbcrKno4SsCFoDUAm6JTXmcl4w
         ZNFLfJ+8nBhzc4qmRV46EdBNShSTxTFarrC+mkbxl8tVwMfioFdVxoJ7UkVgTY2KzgZv
         tSdTHKxz8HrhGBooo5TBc+7xJzr54uZxhDKnRb/NuBoJo+2A4Xd4M6IAsNUETAobwx84
         qQcg==
X-Forwarded-Encrypted: i=1; AL+hErE1LDY8CF77qJmcEWPhcjzKKs6q56MSOyopbqCeV+rKkvEtGB2yOdoqq7+B6I472ZzpYwg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/hVwo5neqRXyQiJxRa5kIr1ogARqljv7Tg9IO4hHuKwRnFPzr
	G1B4tJrxGc5Mt9FFmmPjZg+1RzxdR+TFZPRk2EgylNVjF2uZP7WBJFIT
X-Gm-Gg: AYBFou3WM4950PW3Oxf6gmXWsW9g8M9XsYEhu58z3BnF+4X+Wi5LgV7j7RjQcgdhOT2
	CYlW1WSqlbYWPeoXU65AFlaZaGbhleIx5Cbd2glyqDw5QaShgvhNKj82Dg9iBHVBX1wMS2M4V1k
	LNpw18G0nHMKBND736xJsJ4WofZhf6t0fphTOZjD/mvV9xP40XLE+yGkDoyt7V+zxrX1dXh1+t7
	E1dkA6MKxsk9J1u5VsK6V3J7Zy+fq4yjqOZFkXEeZezYwOXVRKmIBCalfCdYJEdDz8fM1XEid7M
	5jBnuvEhCHzujPgnLyD3Z2FgcdpHywA9IsWSUu2rSQOK6IJxzoN6lyXRtCOnVmb4jtq5cjzfJdn
	uYhm1FOdt+5rsqjExZUTm2BzJFRQBaaGMHrGhL6UT7AAt+BLqVTLX7M31fmsMZsnBLG01maFRQK
	qZUmfuQ4GGXH5IFD316y8xnnCIB2axYkcn62r0WCz2/gLikJydQG/rTOFSgc6dYGwYxwFWsIPfT
	gjoQ/g5vUcCo75wcKljOlZmWc/64RyhPOF4VUZctKRj/Q2hYqa6b4OVUxSzCE41ip8nyXMiFo+c
	vWAS7IaBAfGkNjgFabyUN8/lk9Gtpl6tiB1QFNAIvef/ZEbNlmF52t0CuxypyPoYtG1GnaEjFXa
	KINmpcRP9yD4kB75YokeErUwtqbhVkjeLcw==
X-Received: by 2002:a17:903:384d:b0:2e9:8bd4:577d with SMTP id d9443c01a7336-2edd7a729damr47100435ad.37.1794457207335;
        Wed, 11 Nov 2026 20:20:07 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7bb64sm27813465ad.28.2026.11.11.20.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 20:20:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 04:20:06 +0000
Message-Id: <DMSXZO5WWV0C.392TVOFZNS4OI@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "bo cao" <treebacker@foxmail.com>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] bpf, sockmap: Fix ring capacity invariant break in
 bpf_msg_push_data()
In-Reply-To: <tencent_84A432FD1AE7054D384BEB36958789AAFA05@qq.com>
References: <tencent_84A432FD1AE7054D384BEB36958789AAFA05@qq.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 11, 2026 at 07:13 PM bo cao <treebacker@foxmail.com> wrote:
> A push at msg->size ends the element walk on the ring's free slot, so
> the "no space, absorb by copy" fallback reads the free slot's length
> instead of the last live element's. Nothing is absorbed and the split

Way too long.
A push at msg->size on a full ring reads the length of the free slot.
It is 0, so nothing is copied and sg.end moves onto sg.start.
The ring looks empty and the next push overwrites live elements.
The prog needs CAP_BPF and CAP_NET_ADMIN.
That's all that needs to be said.

> put_page() on a zeroed scatterlist entry. With the fix the helper
> returns -ENOSPC, the message frees normally, and the crash is gone.

It doesn't.
I don't think you tested your patch.

> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")

Wrong tag.
A push at msg->size returned -EINVAL before
commit 15ab0548e310 ("bpf, sockmap: Several fixes to bpf_msg_push_data").

> +	if (!space || (space == 1 && start != offset)) {
> +		/* A push at msg->size leaves the walk on the ring's free
[...]
> +		if (i == msg->sg.end) {
> +			if (!space) {
> +				sk_msg_iter_var_prev(i);
> +				copy = msg->sg.data[i].length;
> +				if (!copy)
> +					return -ENOSPC;
> +			}
> +		} else {
> +			copy = msg->sg.data[i].length;
> +		}
> +	}

This is overkill.
Replace your slop with improved slop:

diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009..c0db554 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2897,6 +2897,10 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (start > offset + l)
 		return -EINVAL;

+	/* A push at the end of the msg works on the last element */
+	if (i == msg->sg.end && start != offset)
+		sk_msg_iter_var_prev(i);
+
 	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);

 	/* If no space available will fallback to copy, we need at
@@ -2922,8 +2926,6 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,

 		raw = page_address(page);

-		if (i == msg->sg.end)
-			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		front = start - offset;
 		back = psge->length - front;
@@ -2945,8 +2947,6 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	}

 	if (start - offset) {
-		if (i == msg->sg.end)
-			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
 		rsge_copy = sk_msg_elem_is_copy(msg, i);

Pls tag the respin as [PATCH bpf v2].

pw-bot: cr
