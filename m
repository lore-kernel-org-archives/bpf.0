Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423440;
	b=SE7OUvSjvjnBCVP+aasXZzA9H7NldTf6mybOpj4L0r0GU1yX5fbK71gLYrKsLy8dWmzC
	 38Zfvy24k1urgIApDN/l13FVllCx+mGt1zwlxwMhF0q6xWvQMjnK04PUPd8HGgasLqlht
	 h3T/FLCVzaNCmPpQELWyPfW/ayBhnqJgKLvQ2HMtxW323jQ6sHTQbGWXYr3hr6FAb/zHy
	 +OmZQrJJDJpEQQ5RZPTKWDD5Rhn1GImXNXz16VQOz0gXpL9Va6p+yEe4enPK5nD0typI0
	 2bfJJxTxPuzyvXJysYwCIOKzmyYX/NspcBa4tJGnNKlqUrdARLmY7bv+ttEvv0FbypQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423440;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4eLFyGKiPJMtTIXftX4CvV1KoAV13HYov222ZjSdPFg=;
	b=bR5L8Lv4SkrPZesLsIj2wPwHRtS3VPF/0KGoXN21uru9c1Iqx7+EUez4BiUIHO6/RcA6
	 f+VpRNzuQlxBOY3GXvZcJvGY4Zzr7PWoH4k/ObVlqsxM/q2+B/xel4YzonDuSt/0cd4go
	 ZiKk8mN7tQfz258vF8ALluUfpYnmkbPIpEgL78AUSzEtxaxptwq8vCYh0yIuxs1AWfN9y
	 o73GVbLluqlpaVmg7gv6N+dOWeswMIaDkTr/ziM03kx3J3ypU5zCXe+RHNGmkO4mJ4GBo
	 OAUmuMp9xvUcGcObd6sHANL3TZ3hErR9BztS3R5qMVHiS6AtzK+o108xwVE2Pw7LQGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9ewDfpJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92B60AE2C7;
	Mon, 19 Oct 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9ewDfpJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2961F000C4;
	Mon, 19 Oct 2026 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423439;
	bh=4eLFyGKiPJMtTIXftX4CvV1KoAV13HYov222ZjSdPFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L9ewDfpJ/rXX/VusF6ChIIgdlRr4Mu2B6zySEt7rPafwX9G0O1uxQ4Y7TcXRPaTGY
	 qAtRiYvkDNpm/yMGv6i5xw9izYikkFlhNQU3tGt8I/2wDBhb84fsSwDG3SV8Gbjlcp
	 M83ca4OfJiG5/3t9bVjwIVtxCet/Yq7UVeU4nqcycgt2lkhFla8FZvmeqbKKnUsJpS
	 EtJOZzlpu1KLBa67Lc5FnOwWLTj294uTR34Mjzrg9JlIWo9AHGt9Z/vpzIy964euEc
	 5WmBSvKgAd8sg4N8gXBfWwWEugVP1hChxUFQE+AHA3RLsa6Ek38Y/nDkyvVWWrzdT9
	 XOe2DsKSyrOqQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 02B55F4006C;
	Mon, 19 Oct 2026 11:23:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 11:23:58 -0400
X-ME-Sender: <xms:DTbWartuLlGuZo2dtWjtN0OHMsF-bdCWW_0uZCCOmE9QTUHQcbpTlQ>
    <xme:DTbWalSXuN05qoS5nOPgUua_UGSpxuW9s6jCRCfnOdKsDgMbrs0YtV0EAOQVAH71y
    jxKC1mSMzBc3ihS2wUX5iXmKtJ_STKgwPuVYI0BJxKqc4t2JKJoSw>
X-ME-Received: <xmr:DTbWaluh0poHqK9Mt4s6gO5yxWobYkbm-RLre7kC32cz7Slt8Po_b5YC9usQOM5k9y3bMYH64pZuxBDXd79nwCehhRAEbGh6>
X-ME-Proxy-Cause: dmFkZTFxUJdm5wwDentUf4q7O59iYNdwqKMnixhSgaLkk1fmocLKobKbM+RyRhTm3kqbdq
    GZz1WNVgJ4bDjAKGKvmLqSew2Px0JG93axkc4pJiL2hDyhQLeVD0oK976RrFzwNrD8BGUB
    k9eETPX0MopLAArJxEBE50QEp1+eOrzpGrqCPlJrnOzmFKtzUP5P/pmVNrzV9PFhWnZcjT
    JRsPBHli9gBJ/NPuYbhLRHsFOoiYmLsy/TZpVX7tp5vj25GVMyy6B9k1tw5KNWEmZRjkiM
    GAnqDGAkEW/7RQMK7IMUucuyTUFH13h1YK10BRSQQeHASU32MqLno9keSqAb8xdY5ob/k4
    GKm6jVCUbKizvaFI7aUs9IoKa8fpHdYlKaXmWDV5mSp/cGIpAs3hVBsPeJn+/CBGmgUXqP
    /54AXE1q8ATTSpcar2rHW43nQG2IFOs7btol4I1wWJCrTvH/YYlfb5jlZ2lzQVQogUQCKB
    CAHgA4nSiFb6MNJWQUZh+LU0qgoriSl3Gt5YQLIlFxeKzFS4pczKyPN4bSZPAm7kxNY4fr
    bCHNg70cJtniqHnw+YwZJivITsCpII5auLOaebI3DZRmoPhey1PCIn7EGSQ5gCLcIQOn9W
    qXEKvMf2zDkkVfX2XiJX9p+tfOalan7a9dTWceqHB+jXf0KMBbTXlgdHLZuw
X-ME-Proxy: <xmx:DTbWajyr_ZzqWGmZfzfijrnq4uME813kGVFi8SNBW8MS2cdLbt00yA>
    <xmx:DTbWak3I9_9gBqgsLk-Peu6j2xslkVV-qtNDo__0nYpB9nXUTqNO6w>
    <xmx:DTbWaoxZ_uQiYZdXGu-aaRx7Mwg2UsmwrFVJPBgm1m4ebsPEnr89ew>
    <xmx:DTbWasMpMflFqTSh23j0pmDFu4ozJUjwi-LV9Fr_6e7_kIryrfCNKA>
    <xmx:DTbWal4YOe-vTzbp5n4oqfMxwvBIjsx9tWMyVBFzH8AUUCBKo62CBUO7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:23:57 -0400 (EDT)
Date: Mon, 19 Oct 2026 08:23:55 -0700
From: Boqun Feng <boqun@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3] selftests/bpf: Use the new NMI_BITS definition
Message-ID: <atY2C77fARQNgWp3@tardis.local>
References: <20261002102923.45846-1-boqun@kernel.org>
 <da2773b2-1ed2-40ef-aefa-0e754cdb2f9d@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2773b2-1ed2-40ef-aefa-0e754cdb2f9d@linux.dev>

On Fri, Oct 02, 2026 at 09:50:02PM +0800, Leon Hwang wrote:
> On 2026/10/2 18:29, Boqun Feng wrote:
> > The definition of NMI_BITS was out of sync after the introduction of
> > HAS_SEPARATE_PREEMPT_RESCHED_BITS, hence adjust it.
> > 
> > Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > Fixes: 3b0e2a22d408 ("preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS")
> > Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > Cc: Leon Hwang <leon.hwang@linux.dev>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> 
> lgtm,
> 
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> 
> One nit below.
> 
> > ---
> > v2: https://lore.kernel.org/lkml/20261001082519.16195-4-boqun@kernel.org/
> > v2 -> v3:
> > 
> > * Add Fixes tag.
> > * Add CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS weak symbol because
> >   CONFIG_* is not available in bpf programs.
> > 
> > 
> >  tools/testing/selftests/bpf/bpf_experimental.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > index 2893bf06ff25..a09448347966 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -367,11 +367,16 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
> >  extern int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
> >  			       struct bpf_dynptr *value_p) __weak __ksym;
> >  
> > +extern bool CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS __kconfig __weak;
> > +
> > +/* A trivial macro to make NMI_BITS exactly the same as in <linux/preempt.h> */
> > +#define IS_ENABLED(cfg)	(cfg)
> 
> NIT: change this to ((cfg) ? 1 : 0) to match IS_ENABLED() semantics.
> 

Seems reasonable.

Regards,
Boqun

> Thanks,
> Leon
> 
> > +
> >  #define PREEMPT_BITS	8
> >  #define SOFTIRQ_BITS	8
> >  #define HARDIRQ_DISABLE_BITS	8
> >  #define HARDIRQ_BITS	4
> > -#define NMI_BITS	1
> > +#define NMI_BITS	(1 + 3*IS_ENABLED(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS))
> >  
> >  #define PREEMPT_SHIFT	0
> >  #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
> 
