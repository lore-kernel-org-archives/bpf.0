Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792530422;
	b=bWOYAyS08iWj+GiOUPV8OvgqBDtpEyB0tpSUBZQ/NAjN+44P6ok2j8cZd7S6/flu5rzd
	 jUAoLln59DpSWPmhrEuIXdWLo6BN+f8MDvl3fv3MqE0AZuv7q45pHH0kOpbJIAx5dmDgg
	 S/RqFnLY5BDY0cL0taLpT0QJx28675JVUvoiJum93KYd/srpJiY6ZspC3gVcbYiLATKOZ
	 IhR6Q9/uGvK5t2bQZXehmb83J5iVanH+larilpxSM6j2r1MnjHZBfzwJmxWH7kCw0LMfx
	 MtUcFZtQJ5QUVrLFdFkJoKaXJbbnhqUcqxsrvb9IlhudGl78WrR9fPKbcoMPANf+nig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=YLJAEyWgWD+owz8+apEIXzolE9JgI3rEa6MIslADBzg=;
	b=IUPtM95UmuZshqxfOT031ydXZ9SF5fEqSp7U1CjPviCjHA5k/28NnypDZzP7obH9hn2K
	 vkAzsZR6+ExgpBfuy3Ot7gwVlEB40rBCth/KsgpFUsHDejwuixd2+X0E2CMQYcMQK9Hhu
	 kodTmqnrImpSGk919lQ/aXQDd0XKJ7URSJNVtTvyFo3c10bNJJp9jv0FOcD+djsrMZ87h
	 actUZa3fucbSeRrPVgO1S5SpQfDvIMjedLGYXUtWEIiSfbZw+THGTuTF0jDtYkuaXJhmW
	 lKjIbOQP7jLtfClLOzg2CGC9GOBFRdf5D/RpF3Ly7TfFVMJTvlPsrL8PfFdov8MK+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xo9u1Q86;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C77606A31D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 21:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C77606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xo9u1Q86
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so9120eec.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792530421; x=1793135221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YLJAEyWgWD+owz8+apEIXzolE9JgI3rEa6MIslADBzg=;
        b=Xo9u1Q86eghEmTqL8We7UIsBOyMUz3YRXxCGgw9PT6lz96S72SZsImsa9DvLMPheyS
         JEO+FfTnrrERLJbvkio3/qwoVkQu+fKAoWkNBceM2YVYmAzyWm2btFEQb/WnrFe/BuzC
         TjIFiUvXIN5SpRgq3NHs5ZcBbGyWT4ZDT+KNS+JBDqupaRQnbrolhiMhh2JoVfnv59ub
         gMvd5H705otAvD81ApzR9N7cRInmlL9E5+Y48v6GUGFZq3a5+gjFrQDXSbI0Iq+5OUG6
         IinUvJnN3oOwFnD6R+1lLjE0+MpiBJZRDwoYrwaYaPqXXgS3LLSqMGgmd7IhJTpbc3ew
         Y/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792530421; x=1793135221;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLJAEyWgWD+owz8+apEIXzolE9JgI3rEa6MIslADBzg=;
        b=PFCBGbA/Vr0/ctw0pTeAmUfGTtAQRL8D81gicIj/T1Pk84wfpddmDk2FK2X4fmI2aZ
         FGVvM8WFWutxIK09YUji2EGBMJz7mbGAANWS0zHwYCW66l3BiKjzrvLDa7/fvdn5IY3i
         kOUtYOJwKX0UkIX1P6CufqwsGKoDtPoQ8LBeDIevg/PSHZa/+C7aYl8PuE8aeEii94va
         jpuMe/Xbdn0Qa3fVki5F2BYjUrkdaz6MXwfvMpKPC3MJr/puuRldgpdYVa6ODD+lq2sr
         isM2IzHEjTNsEeB8SUiFhm3xbwrDlSUW4/1IktFqsDluY9qwowfWwOTHySOj/p2/fwvc
         I6UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpP3XkVn/5qwd9aizsOXFOL9agpIMuDL/n3Xro7Rw3q/Y3ZhJLZU0D0pCJ3aQIHvZFGIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO1PhJAI3P4VNxyfvgnxgI3X/ABwyDXaTM1Y03lsTNxjcMy9pp
	VsA9aauWHwMHcl0hyqlmhdX7RTS9tA0XTrenc/CUUzyaywX4FwnRjXpX
X-Gm-Gg: AYBFou03KqDF3516BRx1y9MywtVTewWnfFYkmkrMl7hpF6/88fQ4bh8eeduzCzFnjXZ
	rTcK2/wokAtlxXa9SWBtCCYTvVSHmeE/6ZcqrdtZ9o3pzMhXpbdKEKMy1yJriYH8YvJ5ep5vG4D
	jsd7becfIvDBuf4HFbvuSZmGK2H9+YVUxAO28rUrrAWCnk6flf5FeleMyN0KhW2ARxt1rwFn08B
	RcpefRXLvy/+dxyoUIQx6TU6pyftK+N0AzGtSeSLwkcoee7JM1T/B14tx7USZ5YnbpB+rz4xTFR
	fwcj7A3yE/qhxpuKXyd6dShpAqqXzVkrcraDJimHOXW6BF5FV6gHZg7dcLGLSmPtKXnQvYhzXfF
	Rp4lVXxGNvPTTaBp1xu7A+mtuLdqGX55/ehAe9S8y10KRHecXBbeKuly43xM4t6R/A43X3qYyBW
	/UKfXe5EDd7sAR6rCZzH1N6OBnDqy4y+eLCc5uyQFiMVdTO65q5Ibh8pht4Fdh1ch9/EFo8hEP0
	TbBC43x62QZoQ+xZx0lAMiJUdV+dPev2bM4tv9EYT18VZvm2op3MfXPlX+dTAf84r8=
X-Received: by 2002:a05:7301:618e:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3674c63d579mr616592eec.10.1792530421071;
        Tue, 20 Oct 2026 14:07:01 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2946:827a:f5c3:d83c? ([2620:10d:c090:500::7:5753])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367416a1fb9sm963662eec.20.2026.10.20.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 14:07:00 -0700 (PDT)
Message-ID: <94c04d9a833d73c368ea9d6bdfcbded27556233d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: support 32-bit linear scalar evolution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bot+bpf-ci@kernel.org, 	bpf@vger.kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 14:06:58 -0700
In-Reply-To: <DM9YUX1TXEEC.1FCUJ0M8D7HGU@gmail.com>
References: <20261020-scev-32bit-v1-1-838f34f9f0cd@gmail.com>
	 <77720df26bea4edfd16a92d307115ad152f9ab558df8848fd8e0d7cb31e9f5eb@mail.kernel.org>
	 <DM9YUX1TXEEC.1FCUJ0M8D7HGU@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-20 at 21:00 +0000, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 04:35 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel=
.org> wrote:
> > > +	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
> > > +		return false;
> >=20
> > For a pointer-vs-pointer JMP32 latch (allowed for privileged programs, =
since
> > check_cond_jmp_op() only rejects pointer comparisons when !allow_ptr_le=
aks),
> > can the computed max_header_count end up smaller than the real number o=
f
> > iterations?  bpf_widen_scev_regs() and bpf_clamp_scev_regs() then bound=
 the
> > induction pointer's range with that count, and the memory access checks
> > inside the loop depend on it being a true upper bound.
> >=20
> > Would it make sense to return false here when latch->jmp32 is set and e=
ither
> > initial_val.ptr_reg or bound_val.ptr_reg is >=3D 0?  zext32 latches can=
not
> > involve pointers, because ALU32 on pointers is rejected.
>=20
> Yes. Seems like a real bug.
>=20
>   r1 =3D map_value + 0, r2 =3D map_value + 56
>   l: r1 +=3D 8; if w1 <=3D w2 goto l
>=20
> max_header_count is 8 and r1 is clamped to 0..56. If the low 32 bits
> of r2 are 0xfffffff8 then w1 wraps to 0 and the latch stays true,
> so r1 walks past the map value.
>=20
> pls fix in a followup.

Yes, and another complain about clamping and possibly dead states.
I'll send follow up for pointers today. For clamping need to think a bit.
