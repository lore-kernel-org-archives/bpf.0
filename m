Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BF347FEA
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384580; cv=pass; b=bd2s3JERXHjYLDFmMSv6nYuWhdTEbKYDTx8BONd09DR56TY5FyTz4QqTUUNUn1+3cAqqwewByL5kjfg7Hb9PRsad8R4NULr/yuazLshAuSIrfewgY+iUX2HsEWRfEzWsxVxZ2qjP4LM3KK7RTJ/cHk7gp9isMOJcxblxQnvjRSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384580; c=relaxed/simple;
	bh=i74FezqI7E0SpoWC2ZrhS62UMbn0hlIH3X474pv57ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bixRiFhZ1CxHuPuI/n52hUfFHAbphJtfECjo/eejLtHoS1ibI+0NMqwCGUFn33fdu9gR14Ng6HECPolUXYBaaqQCE/jJvOiVIuXdBCZXwSRWdOu+NHpWXz0LTI4qyg/HSDWdUsQXh51iyyytaq5iTJCwRZGsaCEpawQXCuPj4tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzm3f/7F; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzm3f/7F"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56ccdd0044dso201648e0c.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 13:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774384578; cv=none;
        d=google.com; s=arc-20240605;
        b=WttIXKPHwSMEEiYgxenE30y/hUPHdAfhJlA8obtW2ocbdATPRJTjWNw27fDUeXB1Bs
         5rzEgGUPVom9YFt+IlUG1VcFRtZiI/x7BcrMRQ9ga8hF0qsTXohvP3yzHqbww5b/zKLf
         o9+OlgtbRsR4PYCY9z8tn60HVQMBOw1WCcq60rhMKZYMmfOu2AJBB8ntU4FTpBS8JyhW
         wjnklcdNsoqsn67ouJzapwvr4bikLx2i/sWnkTsirzWD8kawHtBhDVeDoa3myFOROUiu
         95d/cHLK+B8xwOYJ8Cxkb1FJeV2Yr2DDLYyeiHf4WhoYZR6F8L8THVm2MJJtyY6aRPLT
         pUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1c7czw1dxomj4faqNMgiCugI9oVAXctdtUkh8f8UVok=;
        fh=mnaLGoc4cfnUeQ2NV6KneSy5ixO4Hl7gCzXM0jQHiMc=;
        b=GAugTZPTp8ty1VEydkRzTg9ATqrlgyP2Gis015yfmwZ57Rnkwk1z4CM+rg6FPe9G6K
         SQ23nAIiaggm6Vk8/H9z+GJlybcH2hD5VsXJkKSdKOyZEiCcIoCdIUJHeI31I0utRmS2
         GLuPiLNFY6oX+4uLkyGeWUbWPYKAfkJQqOwVkUAKsFQd5SnBb1BbK3ZlB7P24K7fDAlc
         T04xcJTo5ZM7wqdXcbBgiMOzs2eARpZNDKWkIv5/68wLxOVP2L9uK2hF+I6M+RNHYz9o
         s+kWRo1a/VLsXraXTB0SKy/AN502kwchldWLJ+XCUr25VnBC6ymQfvaycgb/XwnZqglH
         PCFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774384578; x=1774989378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c7czw1dxomj4faqNMgiCugI9oVAXctdtUkh8f8UVok=;
        b=mzm3f/7FM9twf7OTTFiA5KnlsBlC4DKUjwG4wSgWgj0H1oflktLoFcLrx8qDiUzC/F
         JMbe6B4rU/eTVUhd2jPy7UG8x+AaaE67dAHVLofzoOMH+WSbVh3G8gZu6ZJvOcnWfAmZ
         PXTF4Cc7oPXt8EElZiZ9RiFYoqpQsirUDsLDWmUCQXVfYL0l2jn5rG61XG8OJzGcHB00
         u+LSVRf2haxFgL+zbLCGjqbhX1pimA3IPQf+tezG4dfNdw/Qjc9M4WfOi3xwSU0Osm8i
         JsPT/gbUdJJnTRDXsKkt6/kIzhXSM4uWG6iPCZEm9xpXlxtxILxa4v137c3k0sxgAfGZ
         nFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384578; x=1774989378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1c7czw1dxomj4faqNMgiCugI9oVAXctdtUkh8f8UVok=;
        b=KgXCTqrQhhqBMmqslbdc5rcD4La/dOaYllrIF9qqFH7XUiJE4mPjw/HwhggikcS5AS
         49wbv+m53cxRpp7lmg1W6nu24e7j6S3VmFZrWfL4AGs4b9fYMON9LxzpyMmfstaI/xRo
         I+XZk6Qx+UH2JAKROGsiRTHeAYPzvDH5bYnydiQLwkKxW3KwzcO8OlvQvaF3xdOduw0x
         ZU2OwEmvMXMIfFAtuxaLZY6gqtz8Xj0+gauJawp2v2FjN50zDleENeayGhkjkpNYdjwZ
         hfGMSyLvnfFlF7ihuLOq9JleVN3tdADIKjLdvyR0LFxz6HgjMvEQSy55mXp0QKv/MJnt
         RkHg==
X-Forwarded-Encrypted: i=1; AJvYcCUzRWli2ijfMV+EA0xu5xCyWE8aGUDNMQFg+g2tv8DWjiR8yUtg1K3mpYc5880ipNy+OsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIH9aNdtRmLzuB/CM9PdME7WLxz3eOvTtbQKtddyUSPZ8c/NV
	6L1GO5Su5oFxtwnsxhlV3CBojMo9dYCFqPP/a1JGCc6PM1weL4Q9sqDsjlHjasH33OgOyjKTxx1
	pkII8JuC8WqFU4UKhZvBuhz5llQQ2a9M=
X-Gm-Gg: ATEYQzwsxjbc3AUycbaVe43Glt5aOyp0hYGGy/ZJW1dwTNgHZpDtDhnJdEtimK+LajW
	bgIGJpkpWSurMHKBJLS6D1CRjXHapS+yd+VGZqIRwYVxzhZIXq9e+8s0zJv9kuj9M1Krum9helZ
	dpXPBRMw4XY+arN5qG6+Q9C51MnqYahXwp3GHZMQ+HR6i1E0eGsxh7/xfJptB6Iq2RBPbPMOG2p
	xioT/JaOuWtA1EihP2E2U8DzhnJJ0UmbibUpwrWiQw9Kk8vvgzMprxLsOF8dOexuJYGazQ7B3wm
	w+jqxyHh3qa8k887pkrcqEU1wRi0QWam2PFTEjVh7A==
X-Received: by 2002:a05:6122:d1c:b0:56b:8ba0:fd58 with SMTP id
 71dfb90a1353d-56d220f0b54mr571021e0c.6.1774384578446; Tue, 24 Mar 2026
 13:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774025082.git.paul.chaignon@gmail.com> <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
 <87ldfijz7n.fsf@gmail.com>
In-Reply-To: <87ldfijz7n.fsf@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 24 Mar 2026 16:36:02 -0400
X-Gm-Features: AQROBzDB3rC_N4Zyf_TqOUgDqPFl5mdoMTxLJEn2EO1N_Rw-7p3pC5pBYB1ySKY
Message-ID: <CAM=Ch066+XPxFJTN-QSFLBC0fgfpnvvEfkrGnjsdeTgfTzpWLw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Simulate branches to prune based on
 range violations
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:19=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Paul Chaignon <paul.chaignon@gmail.com> writes:
>
> > From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> >
[...]
> > +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
> > +                             u8 opcode, bool is_jmp32);
> > +static u8 rev_opcode(u8 opcode);
> > +
> > +/* Learn more information about live branches by simulating both branc=
hes being
> > + * taken using regs_refine_cond_op. Because regs_refine_cond_op is sou=
nd when
> > + * the branch is taken, if it produces ill-formed register bounds, it =
must mean
> > + * that the branch is dead.
> > + */
> Sorry for being nit-picky, could you please use kernel style comment styl=
e +

Thanks for the suggestion. To clarify, by kernel-style did you mean
keeping the beginning line empty?
Or something else that I might have missed.

> maybe reword it a little bit, instead of:
>
> /*
>  * Because regs_refine_cond_op is sound when
>  * the branch is taken, if it produces ill-formed register bounds, it mus=
t mean
>  * that the branch is dead.
>  */
> Something like:
> /*
>  * regs_refine_cond_op() is sound, so producing ill-formed register
>  * bounds for the branch means that branch is dead.
>  */
>
This sounds good.

> > +static int simulate_both_branches_taken(struct bpf_verifier_env *env, =
u8 opcode, bool is_jmp32)
> > +{
> > +     /* Fallthrough (FALSE) branch */
> > +     regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcod=
e(opcode), is_jmp32);
> > +     reg_bounds_sync(&env->false_reg1);
> > +     reg_bounds_sync(&env->false_reg2);
> This is probably more related to patch 2: is it necessary to have both
> true/false_reg1/2 pairs, it looks like we process false branch before
> the true branch and they never intersect, don't they? So it worth
> removing a pair of bpf_reg_states from env?

We do process the false branch before the true branch in
is_branch_taken->simulate_both_branches. But when both branches are possibl=
e
(we return -1), we need all the four env buffers to hold the updated result=
s
of both branch simulations simultaneously.

The new verifier state for other_branch hasn't been created at the time
simulate_both_branches is called, so we cannot copy the results to their
final destinations immediately. We must hold them in the buffers until
after push_stack,
after which we can copy them back into their corresponding register states:

copy_register_state(dst_reg, &env->false_reg1);
copy_register_state(src_reg, &env->false_reg2);
copy_register_state(&other_branch_regs[insn->dst_reg], &env->true_reg1);
if (BPF_SRC(insn->code) =3D=3D BPF_X)
        copy_register_state(&other_branch_regs[insn->src_reg], &env->true_r=
eg2);

[...]
