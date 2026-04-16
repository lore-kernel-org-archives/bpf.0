Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7126B764
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360227; cv=none; b=SwXGKe2LbKKtqIMpEwIWWNEdKhzAYnDHBU7gAASTMhgbIInFF8jRKQ2jlJct7N8FoGttZiQ6XWR8KMHs3HdOsF6PeV+cUUcutXd3SpfFrLprIDHyCOw9NXICwphN/yLspIQucDIc++WUFMCMgJL7LQbIHJG860XNPTU4UV+q9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360227; c=relaxed/simple;
	bh=+H3j9a+dISNE9VQDxTVFXesACRHCuwV4w7IB8zYETuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzGdRMw92VZck6Ma1w5cjZZmZH1dY5pVS/noDGF5vYIGHwCO3ClfmgdzCORzcqwL/+YwZn/GyAAJOQwPt0RSryaKadBqRhkujdWPexVg3GQoM2c57//ckkUFXOQmMYB/QwN5UCdzqSZlJe9g1AFBAnALTmpnzyJoS679h+vrlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoQrpxVG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoQrpxVG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a8fba3f769so38140905ad.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776360226; x=1776965026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mq9tMp8b9KWPsVYL3iUYjRD5ZyZ+Dizhj6FHjl3l0fo=;
        b=QoQrpxVG7CYz6+n2m1p7oMIomv/IC77/E7PB3fSahVnULq/bt57mky00sZZHkVuZL2
         LLymRLLVQDT4cE8f5fUJE4QKhayTuURUrdT1t22KEs6ipFgLoMYLFLuxyougEUU2ZnNp
         A8WCvE8Lau/5Z53SyVmaHYeFaYN11rqL8KQFFlnjJnr5N1Ug8IQoss8br2CSQU6OTxnG
         SDs4tTF6L+dgRG0Fn6iV6cHb0APakOP1+b96cHNTK05ahTEWKPdLyfm5aV8ebzuzlDzk
         sZh3Wk2lDEtJCq/E4Cy9mpWldDv3d1bdZajfHyL9fVFGhohyEfyWx/RTDfEi9+VqfLq7
         ma4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776360226; x=1776965026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq9tMp8b9KWPsVYL3iUYjRD5ZyZ+Dizhj6FHjl3l0fo=;
        b=kBwLHlq9VhwrFbi38SWsyfTpq+1M981CwtiMrcaJKaNGsr1I0/0h7l0e+wJIt5eHP6
         Q3SCQAEuyhunL4vM1euQjkU1QHGe3fe5fEqFbzYjN9QbRqXM6hrZAGJ0VWhJnJ654R/n
         SZ/eyRRHwM+W6MD4fr68oGUL6tC3sQfuaR7q35Z8QCdPmQnjLZfizxF8+i0WmNSrbDsE
         QBP8PpGadFpUXFdNc0NV5zytfaq00jhvFfDJ1rFK5OULpEG6m9Mm6MxqS5MbLnl8t423
         gzgHdKm12kdX5UUYy5ETROPih6cuHq0/HGYW1BnnszlevmCibg6f+0MiH6lEpC9OPfNY
         XJFA==
X-Forwarded-Encrypted: i=1; AFNElJ+g+dNinmIPpgSPPcPF7JUCtcfwqkxpb2kqo1kr9j2we9eYtOFBv11ojQSGh4fH2lzH0I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiXYkdGxvT7coq/DlFQOvvRfRbjePGE6bl+Oi8q06SB3Ofd5V
	kKaGIG5vdfgxAugXfIH1VGmIfel3CUE9gBaSaetnbg7DD3VF/te9YIES
X-Gm-Gg: AeBDievqlqrjqRVHWN30LKjJCHCgBx7zImjB43OfVSaqx7Q6p88/yMLa0GqSJVS9/Be
	te4udmKWNr7tN042K5g1Na+zOO2oFAJFyhy5TiA7Jyg+JOy5JdpqvNvoMopM+LHyf1+hlDdT96e
	7HozQbStE2OdxCTS7qjogW61YeOmFzPrK7cf40tcwAnl22Z5jPDNIvnz6kV2oi2ce3bVn7YeIZ2
	CJ692GVpqcVMeDdvSPoZ+cJi6W77lFsbCejml6FAX4OWUVKvC3NfNQyZRCgqkhXRZsQb+d5+xHA
	Dw4H4DgAD3CZS3Q6nw287bCfDJhVAW/CfiywLIpQE/vdMPB0TBPxuqP0hyL7HFVy9og6vfvBLWA
	z0yx+BJme4HL95nPLEX9FIkt4b0nzil8BOhP4p+Wa7tjHlPEGpHjIGBI5KLTu+ba77Q/JZdnECq
	cDaVcbKZWGm+pO0v0CnwvauWBIuTxHneNkn6aDBTPZN/YrWiC1rz4XXB2O58wO5tU=
X-Received: by 2002:a17:903:2593:b0:2ae:5eab:132e with SMTP id d9443c01a7336-2b2d597d5cbmr206813595ad.12.1776360225380;
        Thu, 16 Apr 2026 10:23:45 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef736sm80024695ad.8.2026.04.16.10.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:23:44 -0700 (PDT)
Message-ID: <e98c9357265b69575200f8e88ca76b99c2d05e59.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Paul Chaignon
 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,  Srinivas
 Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 16 Apr 2026 10:23:41 -0700
In-Reply-To: <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
		 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
	 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-15 at 18:10 -0700, Eduard Zingerman wrote:
> On Wed, 2026-04-15 at 12:07 -0400, Harishankar Vishwanathan wrote:
> > This commit introduces checks to detect if the ranges and/or tnums have
> > intersections between them, and uses the checks in
> > simulate_both_branches_taken and reg_bounds_sync.
> >=20
> > The verifier is known to evolve the reg_states correctly (i.e. soundly)
> > on a live branch. In a previous commit [1], we used the ill-formedness
> > of a range (e.g. umin > umax), identified by range_bounds_violation, to
> > detect dead branches and prune the branch along which the ill-formednes=
s
> > occurs.
> >=20
> > Another opportunity to prune branches is when the ranges and/or tnums
> > have don't intersect. When the verifier evolves the reg_state along a
> > dead branch, it is possible that abstract value in one domain (e.g tnum=
)
> > doesn't match with the abstract value in the other domain (e.g. u64), s=
o
> > that there is no single value x, that is contained in both the abstract
> > values.
> >=20
> > First, we introduce intersection checks for each of the 5 domains (for =
a
> > total of 10 domain pairs), and wrap it in reg_bounds_intersect.
>=20
> Hi Harishankar,
>=20
> I thought some more on the topic if checks for all 10 domain pairs are
> necessary and now have some doubts. Ideally, what one wants to check
> is that there exist a value included in all 5 domains.  Unfortunately,
> it is too complicated to encode such a check, so the patch-set
> approximates this doing pairwise intersections.

Speaking of which, how hard would it be to figure out the witness value?
Assuming that __update_reg64_bounds() happened would it be sufficient
to check tmin, tnum_step(..., tmin) and tmax?

[...]
