Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056D3B6352
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536163; cv=none; b=rpUkTVrEEj7Tco/eNdsnxGl19ScxpAYvUOoENaS/mVAUvatM9+N8b2rnQXyywh+4qx8DdGRSHot8b9sMIhO+l94Dt/fceQvR0Eavx16QtFlraPj2EXbyjFaxNrKY5QpGq8c4guoHzNuXjOF4glZihAkq3mCA4QFyVE5R6AyVA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536163; c=relaxed/simple;
	bh=/uwFRyr0e70vsLfP5Z7ZjZd6g/vbSjiMUdls5IeyXqQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnOv23Ks2RGlJ5owH9eT83ZtTY3FpEvqnWPwh+8hDxrLvSZqStCNPebGr3TzwtW+26xfY0t8g2ppiNrwVDC/PKu9xKtsFAs7DI5CBvvbAWCWOWYp6wd53Xe73KGm2Mv5HcsG01lw0RK2S8KoEx2W1RSHMUl7hhYFbTzZ3r6xccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGGFQuXa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGGFQuXa"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-367d88b9940so1739927a91.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778536160; x=1779140960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KzbOTDWUIcvbxViZESEou8Tslep7e7aQLC8OW+VAMeM=;
        b=lGGFQuXaRz3858kCFf03Bpn/nnX763kpIxNPME/9zYLV6dLUzGkabl3Xk4CaK4v1wN
         SuKrfmfYj+J9woOz9utSgrIx768ahXHWsxnTUXWMrbJTTGZ9bhfqEFy29W+knE2Ou5fU
         J4mnmzuScJJ/sTSi1e3XEHZqvfpnmrNayYWq2hmmVwiiiAUb5ntMMlP8SN4Cl5w3qkxt
         KjOdQIY0V1JdwEV+gw7Nis9c1iJ/SAYZt4tcanMqhDN1leoN1kjT23KqOvKWGci4SRa3
         ZLlHuGyy8b1o+n3w8r6hT2kBTLYKkVx8yxyATvvhKTTnDsm5zyNBWVO57RLKZUzWGnQI
         aK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536160; x=1779140960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzbOTDWUIcvbxViZESEou8Tslep7e7aQLC8OW+VAMeM=;
        b=cbQtUYFvCW8HBH15ICvMdaQ0fYdW0dltTJp8oxu5XL+R+FOhdKUscPf3v2tPBkhRls
         BusQrJzrkeIsxf/Foj32V02BgYTq6d683r2ewg/SSIUPtGpVeSS69yHF/2f9JtGUZwxh
         yPTl2LXrbuwH9RHeJLhY7qew/2jPN9rAxoxjMSzU2ZQb+yvOI5fFO/Pbf7845QXbHkKR
         xiDrdbkEMTrpAQKO4uei10hO2SXjvL+t+O+hIoQsnKLRU3vu7McdmI3jTooEZJDPXCHO
         IJC6NtZzRI+z4SA9riJoHh79Qym9xW4XgpAho6YAZj20whi9pM7FAu8+vsEHEXnhUm6A
         Zcbg==
X-Forwarded-Encrypted: i=1; AFNElJ8v5lorADdtH5gC3OKh0S7MLdYxN+XtkPPUVvN/eiGYAGWVQsrpyIph1LT4ehZ6LoTv7n0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2B+bBUmTSkUQgreVqunOB1mu929EEx9095LmbJIucIns9WsiT
	8x6sdxDPQz6grDSfNvJFug7nn6yJE1f+MGJL8qEOdCvwk8WMR0tRVjuW
X-Gm-Gg: Acq92OGNv0XTmVo9lxyIE4aZ8KnAfqNs4G49t5kDIYW5bunjoemvm90ND3uouWFnrnd
	cQfcbfzHahWiybjAKmVnk+yEemXMGPRpYcZHtlTvzmQTgNQLzd0SZerSoxnqGxXssLsvVKylLwL
	loG//Htpjca+v3Tgl7zprK1wsEn5pF2j55Z2Smpq0UdVbKoshNaEsNY+aqt07UznZbz4/xN6rEe
	Azmmq89uNkVRJzfMm1Uf7LTQjPTrgDK27sbAOwwUtiG1XQEmlGAZxU7blTUZ7BUUCgQZhbDBGyM
	H/bzsnfXlops4s06FL90UYI8PC0WGVp+LG2rEL0ZnJi2pmQOHP2oycJEdgGb5oKEVYZKJN87sAe
	sZ0T5/ZbsglpDB6VALCaI7YfDiDnjUpxKwbBnXF0C+kFbc3/J+QVkPWHtmvGeROCSAuKoi8f41c
	/MqH7nZvFQzyi84nR2HMzLGL4XLDhFZRsnSZ2oPddfvrDAgB2cX+PuNHqr+KVNa0E=
X-Received: by 2002:a17:90b:2884:b0:366:159a:c1ba with SMTP id 98e67ed59e1d1-3664c8db9acmr17291161a91.3.1778536160485;
        Mon, 11 May 2026 14:49:20 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d64de478sm8776231a91.13.2026.05.11.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:49:20 -0700 (PDT)
Message-ID: <7cffd25282e426002edc4a371b17816bcb862d41.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: Preserve reg->id of pointer
 objects after null-check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 11 May 2026 14:48:47 -0700
In-Reply-To: <20260506142709.2298255-5-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-5-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> Preserve reg->id of pointer objects after null-checking the register so
> that children objects derived from it can still refer to it in the new
> object relationship tracking mechanism introduced in a later patch. This
> change incurs a slight increase in the number of states in one selftest
> bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
> states is also negligible.
>=20
> Selftest BPF objects with insns_diff > 0
>=20
> Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A=
)  States (B)  States (DIFF)
> ------------------------  ---------  ---------  --------------  ---------=
-  ----------  -------------
> rbtree_search                  6820       7326   +506 (+7.42%)         37=
9         398   +19 (+5.01%)
>=20
> Meta BPF objects with insns_diff > 0
>=20
> Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A=
)  States (B)  States (DIFF)
> ------------------------  ---------  ---------  --------------  ---------=
-  ----------  -------------
> ned_imex_be_tclass               52         57     +5 (+9.62%)           =
5           6   +1 (+20.00%)
> ned_imex_be_tclass               52         57     +5 (+9.62%)           =
5           6   +1 (+20.00%)
> ned_skop_auto_flowlabel         523        526     +3 (+0.57%)          3=
9          40    +1 (+2.56%)
> ned_skop_mss                    289        292     +3 (+1.04%)          2=
0          20    +0 (+0.00%)
> ned_skopt_bet_classifier         78         82     +4 (+5.13%)           =
8           8    +0 (+0.00%)
> dctcp_update_alpha              252        320   +68 (+26.98%)          2=
1          27   +6 (+28.57%)
> dctcp_update_alpha              252        320   +68 (+26.98%)          2=
1          27   +6 (+28.57%)
> ned_ts_func                     119        126     +7 (+5.88%)           =
6           7   +1 (+16.67%)
> tw_egress                      1119       1128     +9 (+0.80%)          9=
5          96    +1 (+1.05%)
> tw_ingress                     1128       1137     +9 (+0.80%)          9=
5          96    +1 (+1.05%)
> tw_tproxy_router               4380       4465    +85 (+1.94%)         11=
4         118    +4 (+3.51%)
> tw_tproxy_router4              3093       3170    +77 (+2.49%)          8=
3          88    +5 (+6.02%)
> ttls_tc_ingress               34656      35717  +1061 (+3.06%)         93=
6         970   +34 (+3.63%)
> tw_twfw_egress               222327     222338    +11 (+0.00%)       1056=
3       10564    +1 (+0.01%)
> tw_twfw_ingress               78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       1058=
4       10585    +1 (+0.01%)
> tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_egress                 8080       8085     +5 (+0.06%)         45=
6         456    +0 (+0.00%)
> tw_twfw_ingress                8053       8056     +3 (+0.04%)         45=
4         454    +0 (+0.00%)
> tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         45=
6         457    +1 (+0.22%)
> tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         45=
5         455    +0 (+0.00%)
> tw_twfw_egress               222327     222338    +11 (+0.00%)       1056=
3       10564    +1 (+0.01%)
> tw_twfw_ingress               78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       1058=
4       10585    +1 (+0.01%)
> tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_egress                 8080       8085     +5 (+0.06%)         45=
6         456    +0 (+0.00%)
> tw_twfw_ingress                8053       8056     +3 (+0.04%)         45=
4         454    +0 (+0.00%)
> tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         45=
6         457    +1 (+0.22%)
> tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         45=
5         455    +0 (+0.00%)
>=20
> Looking into rbtree_search, the reason for such increase is that the
> verifier has to explore the main loop shown below for one more iteration
> until state pruning decides the current state is safe.
>=20
> long rbtree_search(void *ctx)
> {
> 	...
> 	bpf_spin_lock(&glock0);
> 	rb_n =3D bpf_rbtree_root(&groot0);
> 	while (can_loop) {
> 		if (!rb_n) {
> 			bpf_spin_unlock(&glock0);
> 			return __LINE__;
> 		}
>=20
> 		n =3D rb_entry(rb_n, struct node_data, r0);
> 		if (lookup_key =3D=3D n->key0)
> 			break;
> 		if (nr_gc < NR_NODES)
> 			gc_ns[nr_gc++] =3D rb_n;
> 		if (lookup_key < n->key0)
> 			rb_n =3D bpf_rbtree_left(&groot0, rb_n);
> 		else
> 			rb_n =3D bpf_rbtree_right(&groot0, rb_n);
> 	}
> 	...
> }
>=20
> Below is what the verifier sees at the start of each iteration
> (65: may_goto) after preserving id of rb_n. Without id of rb_n, the
> verifier stops exploring the loop at iter 16.
>=20
>            rb_n  gc_ns[15]
> iter 15    257   257
>=20
> iter 16    290   257    rb_n: idmap add 257->290
>                         gc_ns[15]: check 257 !=3D 290 --> state not equal
>=20
> iter 17    325   257    rb_n: idmap add 290->325
>                         gc_ns[15]: idmap add 257->257 --> state safe
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
