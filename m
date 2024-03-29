Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09055E40
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727564; cv=none; b=GhYiXZIwyMf7N4UAvyvIrVpHXcgUtkBxIU9/M0mpYmkpD48mA7yjaXSMesCa4R+hLReThr7EGUwhetgS4+x8dXkZke9l5C3npyy/cQcDW2fREAeoviUEZ++/1rl1tun7QMc/3TXgNP3PJYBAsnBk2F5gAzrPDgwF/Hfuy7L3vFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727564; c=relaxed/simple;
	bh=93fcRAx8zC3XL/YYOz1/itnqEkVWFV9/HC+YNw2rLV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTA9ISzbHK6UTj4VjW2uqQS4fgV/bxZ7/dU3pW1cot3y47OYX2/BQP7Ym3lZSWvt4ZU7VCbn/Bw1sKIRzMl9B0cNtxfu3aZ1hD+m+jLuetZtRwHan5vHgge6iJJt7MoscdFyHLJrTc7CTMIV5OCVFlUwHaSKa80s8GxUNVdmzPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a+ddMKtd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a+ddMKtd"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1114351f8f.0
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711727561; x=1712332361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaRSKMpGgSpfDNUtqSIdr/VVtF3x8hhIBInqqXBE7qE=;
        b=a+ddMKtd+ox2Hv1p/kZINSH9QdrIExGhL1BaCoVO93wGXXUhFyqFidJVBEM8ZiQTIl
         KY7PSq/HDa9QjQ3eRlyMcEwUJRwsQmCeMc4Od+fZQARASHs5dmHxk2DJWXJ+tQbWheZ0
         F56Xa0FaOw2+ozwW6shl8tDWOnXVvExZQ7N6P1GcmVRH1cw0KN/jJ6Rm9XWiSTUHza0f
         Kk/UxR80sC5WHcE4UXWh2CbwoTIx8/Kz2FglZSNzldPeqvigU1vzh+sePQW50bAmT1PG
         6A7AH19VYwyHthVL09pz53+fMVsEWsKL/F6JHqy3lcqjP7tzY91BJSDWmcLQ3NS7N7VT
         dDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711727561; x=1712332361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaRSKMpGgSpfDNUtqSIdr/VVtF3x8hhIBInqqXBE7qE=;
        b=NcxQgO7JWSSrvM5LKKEwgBIDcuOzXMXYG7gkOZWjvn/Xt0zOj0A+lLr9DTtr1R6VYW
         24S9yJPawFqcza8mUn+jb7ZteXK0MHb8qLI1aS06qb2xiXIRUvtNE79n60NUCD3aiGOi
         MYlGU4tbXhijjQ6mlJM9SVaI2+2hqcpf5lRJQOlR+veeBEg/aipzGZZsc5a5O3CiJ6Fz
         cel1eq/Vfa5C0Ync0JvxI9U6x2QFJ88Erxv4iwLF4INXsbAMdo5+zyjt3Ui48N+9b7W7
         l8PdIBXH/U/uK5NqyC/c+GVCncg7EknogcQDlRvN2uWw0VMeRO3rnCShyH8NcU2ZYiht
         i1pw==
X-Forwarded-Encrypted: i=1; AJvYcCUrYYVWKXtRdvgucJCYvnrOUETeGMO0bIqgS1ktxJAlvGD75mxqkgfhSje78rM+v78jnTlrlyEWuTzs1p0t9T6t8WpM
X-Gm-Message-State: AOJu0YzqcW+RjfV+shCMSQ3vvk0RtWS/PyQQuJ3pptKDqR2iaV9Pdp4w
	5Mru09yGdbqP0wfLynYZXMr3EjfdAciDZoROUs8vTI9WuuQW3F/Eewye8pr74Bw=
X-Google-Smtp-Source: AGHT+IGY7HPkzppphxXgM5h0At1hNgR5lKzpQA9yXBKEUqn+LOFbx8z+oJtbHZZ1I/5C6bO8uk34HQ==
X-Received: by 2002:a5d:64a2:0:b0:33e:cbec:e98 with SMTP id m2-20020a5d64a2000000b0033ecbec0e98mr5944277wrp.13.1711727560893;
        Fri, 29 Mar 2024 08:52:40 -0700 (PDT)
Received: from u94a ([2401:e180:8d50:7df:53a:80ac:6d18:d24c])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f20300b001e0d6de7198sm3615107plc.283.2024.03.29.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:52:40 -0700 (PDT)
Date: Fri, 29 Mar 2024 23:52:31 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Edward Adam Davis <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>, 
	syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com, 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, 
	yhs@fb.com, Xin Liu <liuxin350@huawei.com>
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Message-ID: <j6tugwevw3vrcnbf4zxa6apdq4twtmqkdvdj3ndjajajnvltnv@n2cvevln6dvx>
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
 <87y1a6biie.fsf@cloudflare.com>
 <87plvgbp15.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plvgbp15.fsf@cloudflare.com>

On Tue, Mar 26, 2024 at 11:15:47PM +0100, Jakub Sitnicki wrote:
> On Mon, Mar 25, 2024 at 01:23 PM +01, Jakub Sitnicki wrote:
> > On Sat, Mar 23, 2024 at 12:08 AM -07, Alexei Starovoitov wrote:
> >> It seems this bug was causing multiple syzbot reports.
> > Any chance we could disallow mutating sockhash from interrupt context?
> 
> I've been playing with the repro from one of the other reports:
> 
> https://lore.kernel.org/all/CABOYnLzaRiZ+M1v7dPaeObnj_=S4JYmWbgrXaYsyBbWh=553vQ@mail.gmail.com/

Possibly also related:
- "A potential deadlock in sockhash map"[1] report awhile back
- commit ed17aa92dc56b ("bpf, sockmap: fix deadlocks in the sockhash and
  sockmap")
- commit 8c5c2a4898e3d ("bpf, sockmap: Revert buggy deadlock fix in the
  sockhash and sockmap")

1: https://lore.kernel.org/all/CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com/
