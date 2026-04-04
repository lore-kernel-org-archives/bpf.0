Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA866182D0
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 02:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775271232; cv=none; b=K/exxl4B6vHArNaPXjC1ZmAJ9ZPiRTUewoTwFc7A7uAPP1sFW1jaDCnZLgQUD6cdQt356z1y8Zu/VFpzf4znJWaXQrLYal8fuK84qgFLePWCihR497Fuga2gLHTLwdgtECbIj8BLMEpmtFCuNIc3/PK+B56kuAcpNg6m7s8E+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775271232; c=relaxed/simple;
	bh=V1q1dAG9ufH/9FW+UgY7NcjpjjPX1SyD7IzYUm04Om0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/NdBr8kCL+3z6TxI8Gzz2oU3Hsi0J/0J7uOU/79en2Z2LPIy1PuH8isLhR6LTm3U+N+yCNHfprIKcuWE97l7RsMfQfFfzjqc/FMmwEewsCykfyzDG6KgDQpDxp9GVLwLBmt/w6MjaXcJ4JmMwMbIF3IPjxzLx6BKtGQZyUUDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSViKBaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSViKBaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775271229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0XCfKnPJaFSlTWn/XIqPgIi+kbJpmbkMrXM5wMampQ=;
	b=DSViKBaG0dRRUatA0Oq+0GSoJ6tyk2w6U6rxDXgyqS/l3ysZxGueFpgs/c3PyTmnawi+/W
	xStESdFY8BpOZvhTf4/7I7O6Cw6/rrGWIP2p1zIaJ6TsW1iIA278USfQuLWvXE8BppmfVB
	3MdQaczKTjlRhnD+VX4Mgma4a/kOmLI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-_zG_lsPbOg-bdAOUdbcXpw-1; Fri,
 03 Apr 2026 22:53:45 -0400
X-MC-Unique: _zG_lsPbOg-bdAOUdbcXpw-1
X-Mimecast-MFC-AGG-ID: _zG_lsPbOg-bdAOUdbcXpw_1775271224
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB5DE1956096;
	Sat,  4 Apr 2026 02:53:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A94C19560A6;
	Sat,  4 Apr 2026 02:53:38 +0000 (UTC)
Date: Sat, 4 Apr 2026 10:53:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>,
	Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
	Xiao Ni <xni@redhat.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH V3 05/12] io_uring: bpf: extend io_uring with bpf
 struct_ops
Message-ID: <adB9LSR_9toDBhSv@fedora>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
 <20260324163753.1900977-6-ming.lei@redhat.com>
 <5e8766d3-a801-48e0-8d27-60e75523ebd1@kernel.dk>
 <ac88hCYgrFXBX3-g@fedora>
 <ba3654fe-5553-4349-8a7e-7d542bc399a6@kernel.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3654fe-5553-4349-8a7e-7d542bc399a6@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Apr 03, 2026 at 09:44:03AM -0600, Jens Axboe wrote:
> On 4/2/26 10:05 PM, Ming Lei wrote:
> > On Wed, Mar 25, 2026 at 07:49:22PM -0600, Jens Axboe wrote:
> >> On 3/24/26 10:37 AM, Ming Lei wrote:
> >>> @@ -493,7 +494,16 @@ struct io_ring_ctx {
> >>>  	DECLARE_HASHTABLE(napi_ht, 4);
> >>>  #endif
> >>>  
> >>> -	struct io_uring_bpf_ops		*bpf_ops;
> >>> +	/*
> >>> +	 * bpf_ops and bpf_ext_ops are mutually exclusive: bpf_ops is used
> >>> +	 * for io_uring_bpf_ops struct_ops, while bpf_ext_ops provides
> >>> +	 * per-opcode BPF extension operations (IORING_SETUP_BPF_EXT).
> >>> +	 * The two cannot be active at the same time on the same ring.
> >>> +	 */
> >>> +	union {
> >>> +		struct io_uring_bpf_ops		*bpf_ops;
> >>> +		struct uring_bpf_ops_kern	*bpf_ext_ops;
> >>> +	};
> >>
> >> What am I missing here, why is this the case? What makes the use of both
> >> at the same time impossible?
> > 
> > Please see the following code:
> > 
> > static inline bool io_has_loop_ops(struct io_ring_ctx *ctx)
> > {
> >         return data_race(ctx->loop_step);
> > }
> > 
> > io_uring_enter():
> > 	...
> > 	if (io_has_loop_ops(ctx)) {
> > 		ret = io_run_loop(ctx);
> > 		goto out;
> > 	}
> > 	...
> > 
> > So if ->loop_step is assigned from io_install_bpf() called from bpf_ops
> > registration, traditional userspace SQE submission and CQE reap are
> > bypassed completely, then IORING_OP_BPF and any other OP can't be handled
> > at all.
> 
> It ends up calling io_submit_sqes() all the same, so not sure I follow the
> problem here. Seems to me that the only thing that is making it mutually
> exclusive is the fact that you unionized the ops.

Looks I miss the point, will switch to non-exclusive in next version.

Thanks,
Ming

