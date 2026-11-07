Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070718;
	b=Z2hLBGxG+8WPcK9PoAkqdjD3M84dDP4v2/V9q5OeF5+PKiv31twcDgOFGp4ceIJgwvqj
	 x8zi6mSxM9V7aQCzgQo2yTDHPWrLWxKhUad4QluDdatbfnzT7kAwhCjkdzAluWIVbKQoA
	 CPjGcUrLBUbXNrRtD9Y4/m2mtln94QfuweNB7nQZGq3k6z+XGE+7ocj4NS//7F7lOBDDX
	 j/DqLCB4CRWhnYQ5oXXq1ZaOrrODk1X2fc6IX4l58hQZVDWQm6uu5CJnOjqRpdVxix2X+
	 3U6qa9HV4T+x++Hzi0TdlUv2XyGeo1jQlXbSM9FBs1r+la4PabPBBORtQRkSvB+0b/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=/PqEYfsN8fKboACw69R7PChurFpIEi+5npkQNsX9u+0=;
	b=mwrz3JaPVUjwpVOhFsoAw/qZBty/UdHj3dC/wIPdF3QkSk/ZvSimLQbJN7B2xV1v7oxO
	 BVfGzLuQhvuvAsKRoqJClC18dLvEfbrWL9wwQOiZj0KEqeU68vJhFauvKeeY7kXVh/9fE
	 h4BXlUjVVEaga+2IPjk0LVp0w1hGnSRak59XZu4qgDq/f1EyDj5AhipZ+AFdJdH2tQXyE
	 g/py/PqJChBeZOl3jdlTfKNiQWg2stPoLxJVytPrFqpQC4fczv7W78N8JJDRqkbUrSvfw
	 ZrojG0YCLjXyod88siYWzpCIaCMzPZJQb876ZWmlYGyG0qKL+gDUrnRKfMA4dPwiDVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zzp5K3pC;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5F606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 16:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05E5F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zzp5K3pC
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e985106c0cso12465295ad.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794070717; x=1794675517; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PqEYfsN8fKboACw69R7PChurFpIEi+5npkQNsX9u+0=;
        b=Zzp5K3pCMh8rNE+weM0wthNQyRYmYyxgbVrEB1uRpQvXMippaHmWhdEwPZHzmL7y+j
         OiiHmD2QUSqXEqxBuWe5e/2hnBEqGhDMbCI/+jaCNG5ZQWHE0JtOP8Fow6I+i0QjidwK
         asPyYSCdlci4OV9CF0ciVAElnEl5n4qN3XDp/I7agxQiPrO+AglJkpWDkN27xxGtijJw
         dll8gNgFJajYNyvHAIL/7U4UcjOK4/As8JhkJHBXzscnFvRwTrfZCZ5E4OmIrjWsrlwz
         qSOMiKxru/MgcnXCx3lWpbNOmLlo+cvSN0iKL1WpJAqmAXjxsZbinn4B1HWSydcJyMA3
         nSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794070717; x=1794675517;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PqEYfsN8fKboACw69R7PChurFpIEi+5npkQNsX9u+0=;
        b=R9YGla7jeXj7FgFdct4RsJZ81M8j9TIy3aAmgDuTA8TSGyRF6VVkI4msnWvtLqKqou
         XT3DhIwMF07sgaXRQMaRH4V4r+mb/kDOOp/sxz6xmZfX+GcyKUezcEffiP4Gl+SOh2pv
         X9d9zmCKs3yUUqg5lLiOGuS6SBVRIigw/+snHJG94hXwoMImK9IbVJQaWJ+hFIU1iAKN
         j+StFCa2M7Sa3Qfb3V0u9mTH4ESRrMJ4JFS9lZNly4UCLNL+q2nNhrSnKfSgxNTGXX4m
         ZByiastai9gp0p3PVclfotI+hiKPQ2ThXA8C2ag01ZFwYpb2Xf02IMlp67ghoXr4y75n
         ptMQ==
X-Forwarded-Encrypted: i=1; AL+hErGWzIXZyJg6nS4Zvjp6b6FLwvObq/B4pzxoPutbQBIWmNXkHn6s8K8YDvruoSlhy78TFPI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zWzttrZ4SlzcS24t3AkEBymHNkSp6qW/VbjVqYiCo0n1U+ov7
	nGbFXpwwHpdQ6OZqL3cuwn7bB+zSDQKTcWkmb3otpnOpPxa84GWludoB
X-Gm-Gg: AYBFou0K10j7TOpl3tR3ziS41GJMlmPHqkN9usY2OJVoX3AuyoyfL4Da4AQT+SADuf4
	oMM41FBPE/K37LRta0nKcqYKBfpNXc8sLnJbgEoS86ZCzPTZNWm2G3zpfHwAR2yhCaaqGrEaUpw
	9mCEbz3usb5LPTrV/nZuDZmu7jI6+AF36fdJghAYQ34sYYt3kVJuuYmJre2uYrG1na30sE6XL4a
	aiBjiPf1mbOg6fSjCnQ3AfRD6azrxtXWyufkMxSM9VIb2A5jvS6m1sfG4Ho1eO/RcvSU1c/DYI3
	VcYYSG50oeXjVD8RiIy2Fh45Jep41zdey7BPiGdUdPf3jlQJDYVAQxURZmFrduFjNDZl+pZJxjs
	QYJFkxyS5T9rq1v46NWkrGKJB2kbByRzlnP8VapRcMaCLuDgggXAy1jvsi53kctNWfR1eUai3ML
	YkU2xzNVhW4pmf3sNX93jHAqGbDrY+oOrPR0mbTI5XS0w6xNmy9+z3yh+W5ilCjo/bpmsqHvp8K
	uO8PLoeMi65ruM5kt4Zlt8YkuQ7jBagH6BHiedjPFVQvd+d7n429Y53pdt9VCOgdTlbxPYu5Dw+
	nM7RX2OVI7DwN9ENr+El6ZAVlr35U/YTRdOOPgobmmDY5DTclhrWtIx4z6E85WOpv/d6vozenPR
	ckUC+BPdeVJyPr9mALtY2cR3eADpCnSUP1A==
X-Received: by 2002:a17:90b:4c41:b0:3ac:4e18:238e with SMTP id 98e67ed59e1d1-3b0db6fe1cemr6102051a91.46.1794070717232;
        Sat, 07 Nov 2026 08:58:37 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105854fa9sm4300424a91.15.2026.11.07.08.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 08:58:36 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 16:58:36 +0000
Message-Id: <DMP4ZP50NN1A.3CMXK8Y0G0YO2@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH] bpf: fix special field check with variable offset
 access
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261107135419.81491-1-shlomojune6@gmail.com>
References: <20261107135419.81491-1-shlomojune6@gmail.com>
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

On Sat, Nov 07, 2026 at 05:54 AM Shihuang Liu <shlomojune6@gmail.com> wrote:
> btf_struct_access() rejects direct access to special fields (kptr,
> spin_lock, list/rbtree nodes, ...) of program allocated objects, but
> for variable offset access the check is done at min_off only, while
> the whole [min_off, max_off] range can be reached at runtime. A read
> leaks the pointer; a write corrupts the refcounted pointer and crashes
> the release path (bpf_obj_free_fields -> bpf_mem_free_rcu).

Not the whole range.
The code at check_variable_offset: keeps the access inside one array.
reg->step has to be a multiple of the element size.
Every access lands on the same member of some element.
btf_repeat_fields() repeats the special fields for every element.
So with BTF from a compiler the check at min_off is enough.

I think it takes hand-made BTF with members that overlap:

  struct node {
          u64 arr[4];              offset 0, size 32
          struct foo __kptr *p;    offset 8
  };

btf_struct_check_meta() only rejects offsets that go down.
A store to arr[i], i in [0, 3], passes the check at offset 0 and hits p.

Is that how you got there? Explain in commit log.

Also drop "A read leaks the pointer".
check_ptr_to_btf_access() allows these loads with CAP_PERFMON only.

> -			if (off < offset + field->size && offset < off + size) {
> +			if (min_off < (s64)offset + field->size &&
> +			    (s64)offset < max_off + size) {

This rejects a prog that loads today:

  struct elem { u64 data; struct foo __kptr *p; };
  struct node { struct elem arr[4]; struct foo __kptr *q; };

  n->arr[i].data = 1;      i in [0, 3], step 16

pw-bot: cr
