Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551537B3F1
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369142; cv=none; b=IfdnY2+/InbvKau/7ZvyPSEXFzDBq95AVzkWoSRyrE7bUD5AEkqDF2iILj3C1MvlJ7ydhZ3kdxQylO/FQ+RJrQ0rtn5CmH2cEX5Zod55Es18osdlsZAYmB1koskvCg/xXVoWT/N9kXtGKPiAlv1/bWzfuoV3UmSnZmI9+Onjxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369142; c=relaxed/simple;
	bh=j2vmMAgZBEIHOIcyw/exgvoqxhaoAAncNtLEhyVK7V8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3tcCGk4DrvHYYhtVzk/0UJEPCSFp9OIJQ8BVDl+30xt5P8vXFZ4S37Myz1w/MO/s517SnysljhkdoTGxevNYCpItHjlLy2eJe8q/8smG4ll5xST2QAz85Y+ojLgA1NAowWL4DbBYQj34Z6I9+DAe/W37pqayjLtEKHNOqCU128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvWNF0wg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rUmU6YOm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvWNF0wg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rUmU6YOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774369139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0pLGEONAHfojUOfaOSp5cChM4XB6HpkP9CDLtETY2Zg=;
	b=UvWNF0wgSnxfP19DhIuC8JjD76fiIkslCDX4/NMpmxQjVX4QBESwrbJJDbBDYIjiZM21/w
	HtU27K8qMP0CfUO4RM7dbJrJaBEvfkSSEvjugzhh2QF09LhIyK8Aw8gQGls1GFxookIIMX
	HlEicRAq+l6D/vQK/CpMRxgdEeGD4ew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-SP7Y14hAOfKlvnj-PtqB3w-1; Tue, 24 Mar 2026 12:18:57 -0400
X-MC-Unique: SP7Y14hAOfKlvnj-PtqB3w-1
X-Mimecast-MFC-AGG-ID: SP7Y14hAOfKlvnj-PtqB3w_1774369137
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439cbfcfc21so4917757f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774369137; x=1774973937; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pLGEONAHfojUOfaOSp5cChM4XB6HpkP9CDLtETY2Zg=;
        b=rUmU6YOm3ZCZMZ7EHRgBKorXwzUWJWZyvVQK2SXrCg0xIYrY28uBtwIT4j0wrCZOIq
         /GRGXn/UnVt5NfO3Mls1U1Ekx/w0M6seRDG+T4BTaurcKpQlnit7qfYnVBmmmmiJ6RDx
         MFq8Rh+CQUgHb/CBoM0XKX1WtJo/4MZjkruQBBwW65VjtlhrhwOyaFhbmpF91R7iY3oW
         SKcdCmb1T4EuAjfw0iq/pDCufgTmGFYA0Hx9fSo3VWjTx53FjxVCmuw3J/lwqQSp47kj
         RtLHSvMECkQfCmVy8+D6FFworxn8+EsTstLaureeD9XjKhLU+/Ij1ugvz1QzeJyRAscF
         h+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369137; x=1774973937;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pLGEONAHfojUOfaOSp5cChM4XB6HpkP9CDLtETY2Zg=;
        b=Gaf6Ui/YKJT5j+v1DfOsa5EwNDI0riS6rkaXENg9qAo0bV+SBJzcMqrL1VPZGFTXtw
         pQ5s3v5dnpG/sOHmUMV61CXwn92w+LrkZ27MvRXZ8QFWUeiXJkjI7YEKZ5hwZy/vlgR4
         g+qVa2LYow5vlQeS5ezyyiqgKT09nO4IhGGMuKk0lYF6HJZ5jNZ0Fk4cuoTm6uEmXSY2
         GkaY012YmNJJWta6MOWEJ1PZWL/ttuHFq/jLKvr6MXKBTNC46BPmim0R7hFs15QGuM9N
         oNQRMVhAGE/1YcbCwgwxtD14CEAOOOMJZe7WOo/tlI1b3hy7y2QLohve9kmd6AH0hIFm
         0DCA==
X-Forwarded-Encrypted: i=1; AJvYcCUnn7RMisJff6TGte5H+Fwln5kqwfDDjti31px6RtOh5EQu1FvfcP7cPxQDKsOiriIucWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHs/hCRc6j0tBFbFSRla1LIkQ3YJHb/U7RfXz7shV6baJ1XNZ/
	Z1jmfRp+xHAvaKwJin6kmYyNL+EPzhFw9HNvDOmSIZxG/9bE+l2IIo73FkYvMvcbg41xKfEovSl
	pCozhBQ9NygUNVWH+zfR2iyMvxM+K8PsnXVXOnImEumGn9j2JRkfshg==
X-Gm-Gg: ATEYQzwzUckxaxlFcLHY5FAVWyJR1KbAVX4T/sxEB4uJc60xBZ5zmAQy4NQTa8h5bY3
	b8HDKCQjzG48B/rTlMOLz5qq4KdSUG+3ueATb4HD38xEmoAWX6yaI1+2ZfuYpFDaFIcNIAMmLvl
	ecEd7ne6fYFgbFsoBzavSXHjjzJkBDJ13CRGL8C0hEE/0pn901pcn2Sy8wcGMpk27F1i7JOccFK
	wF13NWiVjwyTIl5XB3FpB9XzMl01hPV8qT1ebUIl4Fi4UnouUD21x8sN2og6zzhmK7fibnAyztP
	B8N394zf4oMdbRGuXZD2uNCcXOIFO5oIuFo6ke6MHAv4hV1pAthH73bY9PPXhBfxRAYIfR8E8Fp
	+YdTdSQIWE1O3qDJdqrRfwj8e8sVdB3MiZzTnFJT/2/HO9xcN
X-Received: by 2002:a05:6000:2509:b0:43b:4920:56bb with SMTP id ffacd0b85a97d-43b88a0cfc1mr107780f8f.52.1774369136479;
        Tue, 24 Mar 2026 09:18:56 -0700 (PDT)
X-Received: by 2002:a05:6000:2509:b0:43b:4920:56bb with SMTP id ffacd0b85a97d-43b88a0cfc1mr107724f8f.52.1774369135946;
        Tue, 24 Mar 2026 09:18:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm41173985f8f.35.2026.03.24.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:18:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 24AE35A470F; Tue, 24 Mar 2026 17:18:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, Lorenzo
 Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
In-Reply-To: <20260324150444.68166-2-leon.hwang@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 24 Mar 2026 17:18:54 +0100
Message-ID: <87ecl9mc9d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Hwang <leon.hwang@linux.dev> writes:

> xdp_has_frags was introduced by the commit
> c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags loading the ebpf program").
>
> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
> was to ensure backwards compatibility against tail calls. However, it
> missed that XDP progs can be extended by freplace progs, which could break
> the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
> allowed to attach to xdp_has_frags=false XDP progs.
>
> To avoid breaking the backwards compatibility via freplace, disallow
> freplace on XDP programs with different xdp_has_frags values.

The problem you describe is not actually a problem, though? A
frags-aware program can run on a non-frags interface just fine.

You're messing with long-standing behaviour (since 5.18!) to solve a
non-existent problem. In a way that completely breaks the frags handling
in libxdp[0]:

    Running tests from ./test-libxdp.sh
     [test_link_so]                PASS
     [test_link_a]                 PASS
     [test_old_dispatcher]         PASS
     [test_xdp_devbound]           PASS
     [test_xdp_frags]              FAIL
          Kernel supports XDP programs with frags
          check_load_frags:	FAILED
          check_load_nofrags_success:	PASSED
          check_load_nofrags_fail:	PASSED
          check_load_frags_multi:	FAILED
          check_load_mix_big:	FAILED
          check_load_mix_small:	FAILED
          Test test_xdp_frags exited with return code: 1


Please don't do that.

-Toke

[0] Run 'make test' here: https://github.com/xdp-project/xdp-tools

