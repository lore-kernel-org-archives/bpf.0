Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F73CA499
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649856; cv=pass; b=Xp8xyyTGcrD8gIlQy5ROwV3VIRMK9OfKW10nuMUX2TSMANKeeVA6lxJK0hionLW5o+vA4EJ3+eZy/jLlvBUgbwG88S4UucE1WRb5Y0d2gydYpGyA9E4SMFuQOL8P1yWbu3Mr31FXQ/Qho6wB8Yu6rz10aE7caGTYTQ6CVpjHd5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649856; c=relaxed/simple;
	bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+2Bb2BJzGIE03cHq1zrDs5oJIwtEKuo9Gvwnfbm8FIf7AO6gdVXUN8ED01ud9VFEuj+hdAf9fqkVxaXms7WRSErhU+jbyao2puCzTcZYF9JzYDdgcwEorKnCg+i2EgIw8vtjM4/rnfDJJDpRLyR7YyJzJfNuW+mUW8/wGdA3Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXEE6EtR; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXEE6EtR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e614fdb42so16832581cf.3
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777649854; cv=none;
        d=google.com; s=arc-20240605;
        b=jhoo6WH9nrCx+V0I/TonsItsng4nS8HJaOE6YMn1t7G7MDBOqCc1nZgWl2ig8MfQHU
         xLxiRtrytgE+4qhDwWYoxflBkZoNMeGEDScQGp7xFVsEQId4+QE7rZgstkio3gDhJN9X
         c5cOSjXQFjFEyriHhKFGQdTBS9J/q8VelxYUsA50UBPq10aDxos1F3UQxTQGqbFnrOh5
         j7nCj+q+9z9zP7KfLeMXU8qYOwWJclxvfwcB+H3iQGq4H0QGMzBGH6CngIJIeelHG6mx
         v1NGlBOiU2j4KPrRPuwubp9XfK5fuqMrcAVom0rk/vBHinNN0hyR5tLIxC5T4MIu2xjM
         7yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        fh=Qwt4tMGvjWQB2au6ups0MdHJd6MlCaRXgW7bH+YlIYw=;
        b=X5x3/Fhx1GrDyLhH+xiyki9drU3+eGBOgHa9HU62uiEujqiU6QSTvzzepNlP7Vn9dn
         /FWhaGaha+1p4SvMT6mNgpW7PNm+pEFoj6z/8fDCJA4/Fwe4AfWNsyjsahRjrx8o2Pw6
         7CVZDUmy8/4xTOplTef6NS/7b925DdLL4dDUTEwo9DNcIR59P46wNHzybimHnOjr5Jg3
         ZDm+VKZl3dcvkj1KiAlbumWhBrh06BflDkW0AM50eTK1xydvP7FxrlwBXgbK5c3IhIZ9
         y3g4dYWcCxKGVIwHLMSa8PK+54dweSfK9trKp483i+ICiE1nzmTxz7PxC592Gmaem2la
         u4uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777649854; x=1778254654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        b=FXEE6EtREwYj4KAs1LNIJ1N/UwhJG0PZ7wgEEEvZ7H/ieYXQqZE9B91k20MCTkHwVb
         nrq4yqaZCSvDix9tSJwSVgyjiadaEIGkN91qw3HS/EyVzEKX1gdqbRETmnLar8ldIJ4W
         js244wvNIEnkSWXNcCtdTou86m3rrW74e2r5WC3aikTzH+ObvLrnwStoce5evLSlgRrk
         aR/I/3s2Onm0sFaIQao7dUpCW03Vgjg/FJQLV/RYlt6ZtXvsVj/uKHi3As/5O/eoD+Xy
         aQFqsCfAN1hqAzkp6xDsKuvfOnu9699HEjlQu6Q8PdL7RVTrP1tMLfRDPLUgfjunJ0Ah
         GiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777649854; x=1778254654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        b=U6i37Jo8dndLvYtq2LLSFjEchInlBEQvoas7W2AGM8OgH9g2HfGJiBugf4UDmn+YK1
         pJxvOmexVlcoU+gaq5V+L1RhqmprqfkVYakaLkOwW5qSWfdq3ZroDln8WBpiFA+1VN+3
         4zY4cAX7RSv5GP7jtvIyvuhex8YyCJMMtIieDpQIrUa4AM8t24Q9CoopK75ilWw/K+p5
         +NNUXA7/hEagQIe2anVtF/VDcNUoRa4ThLv3AQmHH7FH/2pjWqhHqWzQd4/UrSGkFM+j
         /vi8eM9fNLwKzAOJXzF7ahzucS5mSkmDxnwONvfwWn5xVgPJWkw3Enj3U9mD5Ri+0mAR
         q9Zg==
X-Forwarded-Encrypted: i=1; AFNElJ/GPgPgr/gXuum1sS3Xj6aKcqPt+7zpbgm25jRnVNTgd1iwwVSty9gS3EYqe6lt7dpFYUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7znQ6cmm5F2JedYBUNwpZrWTO2K6v1FMaAzoNgncc8/3f+ARZ
	ZibVn9saAQghG+V8ukH4kKx9U333sLhcaDHnSgwFzNttrN/HNw23RAvxux0pcipI2tGbfUDZV/2
	LTN6Xk0lli5sv8XrwSsg7NSbIb9/nVIs=
X-Gm-Gg: AeBDiesA+3cWurWhAuEwyqUcx59yZx/5xh7EiuvlAiJa7oYbro83iUQBH8M8mSqvfIV
	yCTDTGE9MrCwv+gfsfa+BW/aNYxIkvfqMtKT0pOg9NHxcGajuCqoIr098nJZ0RU7pns1exXpnvf
	wh08pMyqQI3AxU8T6Epdng7bdPT594nnX1RHKs4Q1wDvYW38fs6J7xkh2r6fqC3+2b8QIBPA5wS
	XQEix2e7uS07+StbfCHvmRI1sxtvGRmJTfD7L/eq5iWrH2NfeMBKhKNUW+Fu7rNL5vP6oJeYaeR
	G+NUxkZu3peWXd6GqRRkJ5YHPRclp0hPV4IpDgIAm+jKWV5BBqBV2Duu8vJytQ==
X-Received: by 2002:a05:622a:1390:b0:50d:86d9:4c24 with SMTP id
 d75a77b69052e-5103e801278mr51004741cf.12.1777649853785; Fri, 01 May 2026
 08:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com> <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
 <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>
 <afCUADdbNrpbEPMa@google.com> <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
In-Reply-To: <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 1 May 2026 11:37:22 -0400
X-Gm-Features: AVHnY4LLx68NFbw4R6d2DByeiT2ksgjJ8FlMA2rRsoOrBqjrTHhEtUSBsgoGVxM
Message-ID: <CAEXv5_jkPwf1EGCd3OkCzsnL_dF8fF=x-RNKSuvNZn24Ns5erg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

> >
> > > Even if we wanted to ensure argument provenance was stuff loaded from
> > > context, the right solution would be some kfunc flag that constraints
> > > the argument to be derived by following the ctx pointer, not whatever
> > > is done in this patch.
> >
> > OK, so it is provenance-like tracking which you were initially kinda
> > alluding to here. Currently, I don't believe that PTR_TO_CTX is
> > preserved upon any subsequent R1 (ctx) dereferences, so we'd need to
> > think about how this type could be preserved such that we can enforce
> > this kinda constraint (__ctx) at the time which the new BPF kfunc is
> > called. Do you have any ideas on how to do this?
>
> I think we'll have to track in the register whether the PTR_TO_BTF_ID
> came from a PTR_TO_CTX load. That said, I still prefer changing the
> prototype to pack the array and its output size parameter together. It
> is even clearer to have a well named type than int *xattr_count in the
> prototype.

Thanks for your feedback, sorry I've been busy this week. I will send
v2 with this change, as well as Matt's suggested change for guarding
the bpf xattr namespace.
