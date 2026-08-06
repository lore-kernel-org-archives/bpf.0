Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16630377A92
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036896; cv=none; b=Cf9MGYadLMDHOccPYcJjY5Ay3vmsq3uLfJsv6p1jAutJZ1SEdQ7j5wvIQN5QOPkTdUoZ4TeJ/lPIHYvoK/sv6YqvKlkS7Z0HV7uWiARz6gfdBf9xZ4EM6XA43LUK3ZeiQfVd/e5QtjrvYzXDJOnOP7A9DEwmzJ7gPzbnpbG/66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036896; c=relaxed/simple;
	bh=2OQH86W3IzRTCMtRpKW6k6IqmvkKOk5bz/iMQMn6lEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO8mhMByGkW0GVQPIxRVcy5FR8rrRTmh94emSSe8RrTbfmvA6bRgXUywz+3P1IY1pn4VGRSl+pBeH0zvbZ55KQZWkYtAR4igZHUylBlf4alk9zCnm2SBka+WjuatIz3gJVwqPBI9n6jwftnw30CRMI2Dl5UtuW1aH3Eh8WZJyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur5iwlUG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur5iwlUG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956242332dso19322055e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786036893; x=1786641693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pD8VJ7I371uTTDELSCJRwqcXCzL0GH7gTjU/vIZP8b0=;
        b=Ur5iwlUGfLZP0Igyk6ZxB+HyPTBjaBBr+q3w4BI1SLWcGLa/OCgEiwRXMnFhs3EH8k
         9VPlxQmhcl7nzoZ1Dng/t8U3Sz+wgCb8bbm3b6BNbKY6eZebP9+bTSG0Oe4yz+kRnoS9
         54Bf3usri5w78rF0Ufju/h5OHPTZLw6wBAa6+Nh1bWhhv8sQVhGdUZ+UH8IMghQW3s6B
         9DZQboPJztCIBm4/2ta9HXTOD7uRsljASSlvEG86rjq8q7LXT4r7nUUkZ/Z4M/+15FIs
         IP5FLTitmVbVByCXb3ueWTI/4z6vhV1DkDv61gueCRzE2ulgtO/6CY1tTf9hm5qB8Ww3
         SM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036893; x=1786641693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pD8VJ7I371uTTDELSCJRwqcXCzL0GH7gTjU/vIZP8b0=;
        b=WrxUVNkgpArS8ZBjhA3rvLZ1suQ57yeQBbown1bFAz0/hq3nI20okGWGuJc60RtK3M
         jyH9W3KhXxbUSybxkk7lSDyfWuReIEF9KEamHTyRUxeLtuqcq6XDMEZHhFO/xa7SsT+x
         bBk5TpnGqqtXLnoweI7XgWUFdbvkhC+oL0ioUsJOofX0/ipkwQCcGUFIr1ZnsodoEuyD
         x39ntljXUph1u2BXEbHgg5JN42N5Kshspbh18hs9q4QbfT9tpeBhUS7KmRj+MFzF9Jui
         LkneHH1CZESiN0JDyygNJJlLPpe8cGSXszPt1TQB8D8s1bbcgOyDE1RTc/M6FhJCKM4C
         si+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrFAalgD6t6fjxzSH5BRy+zhRdLpbZ6EugRzVDgMamk4SBiAx1jYafrqllfNIEbgdKxx4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIyEdN3LpGFGqnNCIWXnzodj9yUej88Tj4pM7B5DmbK1FW0E1
	EAGWy7UInJI7wFz7JH9hwMg8IPwQ2q/B9OmSDJoqywwhQZt/e2qK7t7H
X-Gm-Gg: AR+sD12ZKExH6KHwRd3Z6ZPflmSGfgzdyxdLPL+sh5XGkGrf4E8biayFL7Jm9KnFsYZ
	ZsRNfo1c4NkMn1+5qNmXcozGbmil0YtcN6E4XrVbydsBgMgwbdQHQs/mDf+ZSQXgZE6wJ/ExRL1
	Pqsh+JMbwcWZL2J1mJWkIY7QP7icrC5f3TSEnhTRl2JcY/CK4ibWv5g+f+k4WZO+9Kg0F5F6XU4
	GtiVCiMzlcRo/okwaxk4x69YhuZSlZImI0qpM/JpAtqcq0ZtxUygPgMGG0uMHeUp9pLk9DCUljS
	nioCMLAmN/LTUqy4IMtibJfe0KG1yHHl95GkBb/BJkX5x4kh3TEnYNGqsfkgfrPbbTI0iwF/I+X
	ThP+jIFHMXPSf6ow9clbpekcDwZ4lPgvtuRqe9b3eng18SAduvtF/W/7ppTwkoAhpQV5Tscb02d
	d2UAEjuO67VZ9zoeQ9sMXOTdAj3YMPG6dHB30ukVpkq2LagtrAxN/m27Mu3SKZkyFyoDhQGn61d
	VVusFbs8ngxcakm8xBk
X-Received: by 2002:a05:600c:c3cf:10b0:499:49f2:bb86 with SMTP id 5b1f17b1804b1-4994e71af2bmr205416355e9.6.1786036893063;
        Thu, 06 Aug 2026 10:21:33 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bb9093asm1622265e9.2.2026.08.06.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:21:32 -0700 (PDT)
Date: Thu, 6 Aug 2026 19:21:30 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Song Liu <song@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com,
	kuniyu@google.com
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Add ksock kfuncs
Message-ID: <anTCmv1esr3CWfSf@gmail.com>
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
 <20260804164652.296919-3-mahe.tardy@gmail.com>
 <CAPhsuW7=6Wy31ZKqUiwOOPJA7-39y_DtJXBO8BFj+OUfgnzRWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7=6Wy31ZKqUiwOOPJA7-39y_DtJXBO8BFj+OUfgnzRWg@mail.gmail.com>

On Tue, Aug 04, 2026 at 09:55:44PM -0700, Song Liu wrote:
> On Tue, Aug 4, 2026 at 9:47 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> [...]
> > +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
> > +                              u32 data__sz)
> > +{
> > +       struct msghdr msg = {
> > +               .msg_flags = MSG_DONTWAIT,
> > +       };
> > +       struct kvec iov = {
> > +               .iov_base = (void *)data,
> > +               .iov_len = data__sz,
> > +       };
> > +       int ret;
> > +
> > +       if (!bpf_ksock_has_user_task_context())
> > +               return -EOPNOTSUPP;
> > +
> > +       /* Early check for UDP. Exact limits enforced by kernel_sendmsg(). */
> > +       if (data__sz > IP_MAX_MTU)
> > +               return -EMSGSIZE;
> > +
> > +       if (current->in_bpf_ksock_send)
> > +               return -EBUSY;
> 
> Returning EBUSY is not ideal. Can we avoid recursion by disallowing
> calling bpf_ksock_send from certain hooks? You can find examples
> check_kfunc_call() or check_special_kfunc(). This probably means
> we need to grow special_kfunc_list, which is not ideal.

This is actually a really nice feedback. I didn't know we could add a
filter per attach BTF ID. This resolves the issue that the send kfunc
calls security_socket_sendmsg so we can remove all the recursion
protection and struggles, it's rejected at verifier time.

The filter now looks like this, I'd send this in the next version:

BTF_ID_LIST_SINGLE(bpf_lsm_socket_sendmsg_id, func, bpf_lsm_socket_sendmsg)

static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
{
	if (!btf_id_set8_contains(&ksock_kfunc_btf_ids, kfunc_id))
		return 0;

	if (prog->type == BPF_PROG_TYPE_SYSCALL)
		return 0;

	if (prog->type == BPF_PROG_TYPE_LSM &&
	    prog->aux->attach_btf_id != bpf_lsm_socket_sendmsg_id[0])
		return 0;

	return -EACCES;
}

I don't think I need to touch anything else. I'll adjust the tests
according to this. Thanks Song.

> 
> @Kumar, do you have strong objection that we grow special_kfunc_list
> for this use case?
> 
> Thanks,
> Song
> 
> 
> > +
> > +       current->in_bpf_ksock_send = true;
> > +       ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> > +       current->in_bpf_ksock_send = false;
> > +
> > +       return ret;
> > +}
> > +
> > +__bpf_kfunc_end_defs();
