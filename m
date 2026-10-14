Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6EA4DE703
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970219; cv=none; b=cuw6UVyVjaBF3QPdOQ7g82Nt54j6GYF6VS53M3Oe2zreaUEd+1oCU3yvipvqz5GdMUoy3KlC70vot85ODup+5yLhRBoGRfhja5Vzgdx56a6ZOGegBB+4lGeASrAxTt01qQVstWnpUbePZp/30iFSH/Q6kdRYorXXY2U9FujYmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970219; c=relaxed/simple;
	bh=ABm72ANkX+YOL6wJl0dy+W6rqpbTdAsXa0r+DYkIRxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVcQ//+2BOt7JY2mOFh81ZSp6W0DDkGZrAHlYpsmaF7uuBnOcA3u9z58lkhJ57E2jbqoG11SqTipCCqOHll0SyLnXRfGbkVZ0b9/FGIxZqmm9AmcdeRhyBmXnuETtBiZQo7kV4XGHvHSxYJZOJqaPg0I46ikwW+ulI0QclFy2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjA7qB83; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjA7qB83"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b0d19cf7eso3876782f8f.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 02:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791970211; x=1792575011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l3atJF10Fv+uKvn/ZG4Hw3Hv137TFtSEFfSHB7ENlq8=;
        b=AjA7qB83WtZFLMtSHfgJwJxHEqxf5r4yCPA8QAgcpwLy5hLYKgJpZ5CJQK6LwVLqo6
         RtA1SO0l0CGh7FnhTk7d5GgVBflJxfpGc/qj4QfZra22up1q0gKcFuEU5a4r0w1lVPCY
         AebTQV6R2yY994BE5ccVRw5DLVfVLi9dQxHkWW1txMQw/83aOGSKcaKSgPCbim+AZ+WC
         wMMC0//IdMES4IIW0wkxloYYj0ylUuyZExUfG/tVQMXvgtvGhb6k4fgDSNGyx8Z6fC4Z
         aQZQt1LVuLDzMw6yWVgSPwItVXWCPzmdPiz50WFmt1Sb6PNVtNY9vwsVxtajbLdDPaFS
         QJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970211; x=1792575011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l3atJF10Fv+uKvn/ZG4Hw3Hv137TFtSEFfSHB7ENlq8=;
        b=LfPpgYZir/dQ7b1QY+H9T9zxEi09DqaBS3x+sP06TUm/xTxlc4ewGOELufHwmvcyh8
         3MhZ017UcM9gnNfL48Gk4dv1S3uLg+0yPBxSCM7ENjr/sco+6oFaeCka7apMynKYAvkN
         JTIUbpk5MRNwLern6hZlLNNy6dav28dBmQsQKxe1/PSd/WFbd3ETzpDZUTYsuCGqd0ZS
         EvmkC5eeh9NR21U+kGSj+nO/DyNbi1FtKkymsc8kwJ3rOtc7u+koEvOrRJgRf2OtwPtI
         Xz3tXXzx8n1ygFFUEmqNMbtO69LsHm71tuGroFJO0tSxx0u+9/wfYnX1iTb26my1ESc3
         cbsw==
X-Gm-Message-State: AFq9FYK3fHwNYtCd4dRz+FDziUigycYIbZcfuJxMZoFSqOYwmym2PnVO
	wnftXEUL3Dh2MZAcjyKhEQrZ/13K/sw9I9ve2k73M0EHZRSr8ywtEzKiqnRCB+B/NII=
X-Gm-Gg: AYBFou3/HFCUnHNbAfF6p2Qsx2bl59m6J4RS/Z8i1gXAYYlxGojJef4psJhANNp1gOw
	qaeIBkpe8pJmSWi05rRbcAU3s1epEZfGsuGjYIXMkAZhfHaKp5eR19wLtXd7NMaSiQSvmEB0wv4
	J0VgMpuABmT+YtqG4BdImuVeX9/9Jdp4+JzefcPITWzw1ksr1/wI4G4nsZ7MOQLXYseEAOOnBqZ
	eaeUQ+qfv2jy273abJNFxAIUzYhBoqcmyfXICsMdmATwjnzGwtCJwJ6jfoxJoSAS/qlfHbxwmLS
	aNIJo1id+7uEnHHFrkFXXwTE2KiRJuXNmR8l3wQBiL9dFWrF6bFTB2HDxpO9wdYI5bU59qfDiz3
	faB13yr4hAxvoWElAAZuUMin8H9Roy4OEvoqAJSY0hukXIvbdmE5V3Uee8BH3fx5VA88qewR+n4
	WeFBTYz8P270/b3Hl0rYHhiG1UFa/Iux3Lv3HHyqu2CYUwuPqxEWNpn3lFmXoQGmQ49RZZWrWVk
	qHkDlr73wjvJFnD1B+GdQ==
X-Received: by 2002:a05:600c:4e92:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a18e4837e7mr300689535e9.6.1791970211150;
        Wed, 14 Oct 2026 02:30:11 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b2e9791csm37734665e9.1.2026.10.14.02.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:30:10 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:30:08 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: allow ksock connect/send calls from wq
Message-ID: <as9LoIKMYXAW5IMP@gmail.com>
References: <20261014091450.19107-1-mahe.tardy@gmail.com>
 <sashiko-outbox-171070@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-171070@kernel.org>

On Wed, Oct 14, 2026 at 09:26:39AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: selftests: u64 map key mismatch causes ksock_wq failure on big-endian
> --
> 
> commit e40a8841b185289348c211758c8754c0959c28bd
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> bpf: allow ksock connect/send calls from wq
> 
> This commit relaxes the constraint on not using the workqueues for ksock 
> connect() or send() kfuncs. It also updates the selftests to verify this 
> behavior.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
> > index 16a1873d132ed..290736e219e1d 100644
> > --- a/tools/testing/selftests/bpf/progs/ksock_wq.c
> > +++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
> > @@ -14,15 +15,19 @@ struct ksock_wq_value {
> >  
> >  struct {
> >  	__uint(type, BPF_MAP_TYPE_ARRAY);
> > -	__uint(max_entries, 1);
> > +	__uint(max_entries, 2);
> >  	__type(key, u32);
> >  	__type(value, struct ksock_wq_value);
> >  } work_map SEC(".maps");
> 
> [ ... ]
> 
> > @@ -43,20 +73,40 @@ static int ksock_wq_callback(void *map, int *key, void *value)
> >  SEC("syscall")
> >  int ksock_wq_start(void *ctx)
> >  {
> > +	struct bpf_ksock_create_opts opts = {
> > +		.family = AF_INET,
> > +		.type = SOCK_DGRAM,
> > +		.protocol = IPPROTO_UDP,
> > +	};
> >  	struct ksock_wq_value *value;
> > -	u32 key = 0;
> > -	int err;
> > +	struct bpf_ksock *ks;
> > +	u64 key = 0;
> > +	int err = 0;
> >  
> > -	value = bpf_map_lookup_elem(&work_map, &key);
> > -	if (!value)
> > -		return -ENOENT;
> > -	err = bpf_wq_init(&value->work, &work_map, 0);
> > -	if (err)
> > +	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
> > +	if (!ks)
> >  		return err;
> > -	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
> > +	err = ksock_ctx_insert(ks);
> >  	if (err)
> >  		return err;
> > -	return bpf_wq_start(&value->work, 0);
> > +	for (key = 0; key < 2; key++) {
> > +		value = bpf_map_lookup_elem(&work_map, &key);
> 
> [Severity: Medium]
> Could this cause failures on big-endian systems?
> 
> In ksock_wq_start(), the key variable was changed from u32 to u64, but
> work_map is defined as a BPF_MAP_TYPE_ARRAY with a u32 key.
> 
> When &key is passed to bpf_map_lookup_elem(), big-endian systems will read
> the first 4 bytes of the u64 (which will be 0 for both iterations in the
> loop).
> 
> This would cause the lookup to return the element at index 0 multiple times,
> leading to double-initialization of the same workqueue via bpf_wq_init()
> and subsequent failures.

Oh no :facepalm:, I sent the v2 again instead of the v3 with the u32
change... Sorry for the spam, I'll send the proper v3 as v4 in a while
to avoid sending too many emails on the same patchset at once.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261014091450.19107-1-mahe.tardy@gmail.com?part=1
