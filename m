Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73D39F166
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229373; cv=none; b=FAzo1Box+y9h45P8p41K1KMtgmRcEPh7eXY0dGR9zhuTxiz1PBGXt4s4BTWSvW2zkOYsWpia5bUqmkmIf6/ZqhW6Y5XLyR7ItLF/GjXhaY8GIcUePnag0Km2xLE+O59oVhqFnyLWryw/DK1dzwgZB+kpTmvK4kbomQysGzGLx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229373; c=relaxed/simple;
	bh=PFsqgsfgnZ0F4NBxRigPGHFfA4KXZ4IRVsUbSf/RVFs=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=VELE7Xg/6qQZcZoEvbG1RcjbZC37uqUV4XdBnCOyDB57hk3A1GvrRRKE7EeSZOJBakLgGqT7lwmJ/MEfyQqQk8ho7TfUW4nc9aGAlalbATXRYUdkl/I3iJmSVjlAE7xOqxwgZ0+kP44+FHZBQN6oGJ6yzA96+TNIRF43pP6iWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1hYUjUM; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1hYUjUM"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so7908155ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229372; x=1790834172; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ddc11RZTLsW/NfRYZ6ufKgL8eOQLhIlzC2wVbMASsYs=;
        b=n1hYUjUM56AHvg8eCcYwkzuZKLRPkdlHGvr+xA/pEhnLh8GFvudmFsVFZivmI3IJ3p
         8aGhlnxMXteRNHr22eWGTtMrpdwdwC1USTPHbwkx3fyFFNPZYha8GC2en9L8q4FOxIHs
         h1op2ARRu29U2Ct7gSeGVQ0DRsaTDNxgnIAxVNAsgZJdSG+EbRaF867ZpMaTizQI5/6Z
         JrSfcEtN+53oD00jCDXyfx27kh/b3gWJfl5/uZyWhQbFZ8+pVUUDoeffo9OoveUJA8uA
         Nm3zMN8GGbApeOs/0z122YojiqotAdlQJxlMfALv2u46PVkYvN3nbNlu4muphAgw+Ui6
         vg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229372; x=1790834172;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ddc11RZTLsW/NfRYZ6ufKgL8eOQLhIlzC2wVbMASsYs=;
        b=QcnnhpS8QFFAEyS0dJ1MveH4q9cH3z35Xzo6/n5/4hu+dxFltljl80v2qTmTkdYhYL
         x9+Aj19ipYE1c72MT/3f5Ck6JsbQZTjg+OW38tAcklpOmr2h8aN8iYwpB80UIBx13FqD
         A3hcF4bi6JdeZXwHy2n+Er0vMTFcvocd4UW5RhEXdG9ZuJh8vx8+1WB9uPnXUzEK045u
         QsUJrBf8Vn+HQvwpo1a85pBxjaG+efV4zbstVHTPGO6KOmYkEjt4qyTMVTK/sK3JkTXK
         2slZgr7ZZ3/B7wSLNxZC9ZKBNRcqDVaPBLwibLOLdLwXpqlg3I5QE2QRahiFm2ncJ/Gt
         T4Pg==
X-Forwarded-Encrypted: i=1; AKwUvBxND+elcOcE6R4+SzlWu7RMcUQh0AqhqZF+mt0G+XsGSVaqjgR3OlFygEu6XwE8ARWjySY=@vger.kernel.org
X-Gm-Message-State: AFuF++nCOOqplEdb1Tgg1lf1W0z7uUutXl5HK5N8niiKea7/TRxh1dpX
	dufygi6NeZaQF1RyIYSuoJEDe0gAqqwfJg1OnoS2fPwwyjD2VH+rkEJA
X-Gm-Gg: AYBFou2PggxxkV0KOTKZwg78/se+m2IzD3WHBzNEeRlfHuOUSrkSdgiiAwE8efikC08
	zujuTCwRArz43BTR9Gp2Qf+znOIqm3TzXHJgRp/N2hSNScyd5pYrOuANtGCXReQrFnn89kVMuec
	Y93LTITerd80Esxab70ESUiEXFMDkIi8mAWEToD1Q4VEP2Sp2sDJLdnKe0qFlQ756rZ3EvaN5Vu
	NPDG6lU6T0f3szhbk2O0KXM7fPJXNrWMrQXtZ7HdCVlkn3LdAkN3KyNolGSFmERxK3NDgILUbb7
	WUBSVu/TEBudSeXenonbntEtiPVdrDjbi2BxuhZnH2s0Hk1VUsGaKrAgxqEaF+ZYj6aIRHFHvuA
	h0zx9KMq9WeZAzigj62NZDSbb4p7Fr7+WrafkeTbeszznjlYPYcEU/b6C3KSkF0w4AZg8z0T4FW
	12h4cMhKpy5c+sSccuWIw1/d63aIKO8u7ImNXr2KAw0da1WTpT/Ynw7oVBWkni5G5/IPgJZWtuB
	41XzYp+fWSz9mSPpJR2sjAzhH2JW/LVOT0LB7WTxnC8zOUo3XnUJZdM9qb8ithTCDZSAgjZx5YG
	AkM=
X-Received: by 2002:a17:903:b08:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2df7dc03019mr11410365ad.7.1790229371816;
        Wed, 23 Sep 2026 22:56:11 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a777csm20814575ad.18.2026.09.23.22.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 22:56:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 05:56:10 +0000
Message-Id: <DLNBCJAQ73G1.3U6JELNSXMQM3@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Look at frame 0 when telling async
 callback entries apart
In-Reply-To: <20260923140152.4005097-2-puranjay@kernel.org>
References: <20260923140152.4005097-1-puranjay@kernel.org> <20260923140152.4005097-2-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 07:01 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> -			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
> +			struct bpf_func_state *frame = sl->state.frame[0];
>
>  			if (frame->in_async_callback_fn &&
> -			    frame->async_entry_cnt != cur->frame[cur->curframe]->async_entry_cnt) {
> +			    frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {

push_callback_call() has the same problem:
  caller = state->frame[state->curframe];
  ...
  callee->async_entry_cnt = caller->async_entry_cnt + 1;
When the callback re-arms itself from a subprog the caller is
frame 1 with async_entry_cnt == 0, so every entry into the callback
gets async_entry_cnt == 1 and the check above never skips.
A loop anywhere in such callback is still rejected with
"infinite loop detected".

pw-bot: cr
