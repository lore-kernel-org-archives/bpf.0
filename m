Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A875346FC3
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500523; cv=pass; b=SebEH5WfvuPJc32kOMoWNs0wQ0jzzoZlbUkJLJNyvH7nBwH8IMRXCtawdQHNmgnhOyurjmX35y579ZLuVKCJ7LKKPARD88u3QwkeajyoAxodG6hqYYKScRP6jBTXJB+PbkW96oTEBrlGWY9CtuBKQno9Cm6drjowCeouSO0Br+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500523; c=relaxed/simple;
	bh=j3CKEPZPsZDOQO7eZWdGZhyLgT5/sWBfMGLt9ZQm9hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCxJ4uRx5FrQb9S4jYTaF5IVnS4s8K1l9ZvXhCcTYVtmukxPBxeDTqtO/MEhqAsdKmRzTTJLItAGGiLQmXqZVvPLPFeD2xrO1NWbYFS4QyvH9Vr8ZLMozlG+YsZuXcEZSWl5LhC6ZcH7v3mZNrIimD8CkxoW16AOLYsydXwNj4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eqc/TXcI; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqc/TXcI"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e191c4b8fso1740377a12.0
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 17:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772500522; cv=none;
        d=google.com; s=arc-20240605;
        b=E3uz/uGEfHq9mCHd54HpatKyD2Xu4GbMJ10MN+Vv476f6OPVzurqehBLsAw7/uhPFR
         86/Z4TG5tGZ5+Ukc7pFrIjXCGhj4zHBl9I9W5pJjmEQMW2Y5PGGXCLzJ/uo1C1sAygr0
         GCZo4sx8VoQNUnHBUtptWZFnxW1YPLwXbpHnGnJ/pWaVp2VJ7yKCscTiXQNuY0gj92KN
         fQBNNeIGBorNth7iYnfuk6Nmu1RpLbNT4Rj1VVD+h/WsD7+e4aSD+vanU0ilUGBt6pkt
         8qHb4/d5LkTIGkexs2AWp4Uhn5qyLjfO28/eb1sdHL9AaMs28Mm0K9Bv0MKaNt+erD3L
         sYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRYoOP/AxXhYElkBcV+kPgi4ZqfN6Vv0Q6Lw8WBNcpg=;
        fh=gsDCFrQjFT+RQMN9zRnqni3HBJX+zBweexlGR3oXxwo=;
        b=ivk8C2rYrlivFip05Z3eX3WSHTSHuOaSyaJKRKDQ/LlDRSjsubBoWH4eus4zhF79Df
         R5Hr9gj4iCCp7uKk9VnlPA2DfbU+5nOQb6uWRQ106Z3LSAKvUsU97Irw3Esr9qPrQS9M
         GgC5QGScuKy5QnVZQYeQRYLOFHMeM/07iTqelaa/ynvWgFKSPVNdv3VkG+imKgg+p1FH
         CxaG0+1nOyTu91I9J0357J12DvKc1SMORK/GtNoBm8C2SzHRMtARzeIwUmn6rgZqEBOz
         ZKgWXoF25esnsaN4Yj9xzDHnrsMCuYF7hIKaWLjhupF3BJoDkg9RImAUgceNU8iCcRML
         CAtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500522; x=1773105322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRYoOP/AxXhYElkBcV+kPgi4ZqfN6Vv0Q6Lw8WBNcpg=;
        b=Eqc/TXcIngKaAuTfJAQZeuGZv3nbeikn/Xm/xPScpHuZIErkz1q6Vb5qZZJP0tPnc2
         stjldNvAZUJkETwOrx7I45ovdyikLwz5sH7DnVVbwcCVU6bFLrXdFRxCzsk9nbKlQOxV
         Sfn+KxYaT756tSHrQZfoB4PYDxnwZBOsFcDKRhCoDLLTXOln4i1+jJDI+IfJ7FlCaJJw
         wdwVD+JvFhIwehMoM6Xy6Ry3/wdqZABnuhVyVppjskanOQG0Q1Ah3V4Sw8Fef8wlHoKh
         QWNtlM/1+BlQk/4ODpj7eHipcW+ffXrOBxfq4ghQGPo903jjIkaezRO2JVhsLXL7TChY
         kLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500522; x=1773105322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRYoOP/AxXhYElkBcV+kPgi4ZqfN6Vv0Q6Lw8WBNcpg=;
        b=FaeH2GVxQUPu5LSnpe1P1wufbKp9/ZGS5ZgNDktnug612SVzI/aelxmNXEbzNrC9Yt
         /X6CxGQCY6hkCX57yF/8+O6aFSCNltZLuwiZgNQusQTobLmJEsJkoU8JkDwjYZ7DANKV
         yfG4HJRsPdlw3Q+TeSl3N0c1jn/GvnkNzCNPOo3PDanv57hUnr9KiJnvASQpO2bMcvMo
         tQKdK+p5OURlEOhatyXciv8W/8FKm/l7uust8UDc2CpMOL3yT+2cBSxIDzQPQYyuxg2F
         Q9LVUKUFeZxl7ijbcCTVayXmkVdBJpriBq/TqmUABA2CvyVhPK1KayI/XWRBMltMvTUy
         QZKg==
X-Forwarded-Encrypted: i=1; AJvYcCXjNmxUw/Vxs/5tZvlimErumlTbPZD68XARu5mHWyEE0tn3ABILzzF6I5DvCqM621WK/yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0PT5RSRGM/70mlCrD0DwYkrwlcPBgKCc/iYLLx+vLS9ABFAB
	3s6A+dXiy9Wldm2T2hCAJETD18dgnY9+FNQbc/5h+T8v7nk8SVByfLNDikOlHa5QpC26dRiXfZ4
	3dKCY8D3sji01UDk4bb1uxXXeSdqAz1s=
X-Gm-Gg: ATEYQzysTX2A/tNsL+8KkEZ+rON90ZHxe0WoVsRMcQwHQRISwVk4q/CNlLiLmnupVTU
	wB0CTS1e/jUDVblyM/icAo808DE44kA6guXREsPPrcYuGKjNCYtbWNkYxxaWRJm4GPetZLYOf8C
	VFxLTeKUxp7QnuXGZKcPkpdiGBQgRk4HVr1FrkYZFvAAOgstnYn+P/SIx9HHJmr1mP0PL2f17Tp
	6YeBFOI32/J28Hph8qLdgqjY4mkgrbMMNG6dq3Am3Iq76E6sD3IE5Cjy3kXBMbpzl/Es7+/I3Vx
	rPl71oA=
X-Received: by 2002:a17:90a:d408:b0:359:95c2:b3e with SMTP id
 98e67ed59e1d1-35995c20e6dmr2526045a91.30.1772500521717; Mon, 02 Mar 2026
 17:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302124028.82420-1-pilgrimtao@gmail.com> <20260302124028.82420-2-pilgrimtao@gmail.com>
 <87bjh6ntsr.fsf@gmail.com>
In-Reply-To: <87bjh6ntsr.fsf@gmail.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Tue, 3 Mar 2026 09:15:09 +0800
X-Gm-Features: AaiRm51bdAD-IerN0W9Z2z0y6DQwDknHc4UQ1wwMaHwAxgCFkvOMMNrs2B4XKNc
Message-ID: <CAAWJmAa9_RcjbHzOmufL12gfoNY3eZtgWGjNTVR0sbCR9Simkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] bpf: Introduce the bpf_list_del kfunc.
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 11:19=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Chengkaitao <pilgrimtao@gmail.com> writes:
>
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >
> > If a user holds ownership of a node in the middle of a list, they
> > can directly remove it from the list without strictly adhering to
> > deletion rules from the head or tail.
> >
> > When a kfunc has only one bpf_list_node parameter, supplement the
> > initialization of the corresponding btf_field. Add a new lock_rec
> > member to struct bpf_reference_state for lock holding detection.
> >
> > This is typically paired with bpf_refcount. After calling
> > bpf_list_del, it is generally necessary to drop the reference to
> > the list node twice to prevent reference count leaks.
> >
> > Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> > ---
> >  include/linux/bpf_verifier.h |  4 +++
> >  kernel/bpf/btf.c             | 33 +++++++++++++++++++---
> >  kernel/bpf/helpers.c         | 17 ++++++++++++
> >  kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++++++++++++--
> >  4 files changed, 101 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index ef8e45a362d9..e1358b62d6cc 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -261,6 +261,10 @@ struct bpf_reference_state {
> >        * it matches on unlock.
> >        */
> >       void *ptr;
> > +     /* For REF_TYPE_LOCK_*: btf_record of the locked object, used for=
 lock
> > +      * checking in kfuncs such as bpf_list_del.
> > +      */
> > +     struct btf_record *lock_rec;
> As far as I understand this patch introduces a weaker type of
> verification: we only check that there is some lock held by the
> object of the same type as this node's head, but there is no guarantee
> it's the same instance. Please confirm if I'm right.
> What would it take to implement instance validation instead of
> type-based lock check?

Your understanding is correct. However, I haven=E2=80=99t come up
with a better solution to obtain this node's head. Do you have
any suggestions? Alternatively, shall we revert to version v1?

https://lore.kernel.org/all/20260209025250.55750-2-pilgrimtao@gmail.com/
