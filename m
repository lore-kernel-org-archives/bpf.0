Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170C2C15B0
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085112; cv=none; b=aX9p7SXmZo/Gnae0iYCJZRKvd1qurGO9EIAlWOaHurP8fE+InALAFsfiKt2WRycMA37WU7e1+oEhIezZ1MTYofi++gwg23nNwk26+UykTkzpKQNfFvumJNheoTf36WZzYTQhelq0H5ge1xG76aGE6qvupbXfHm1JnjG5ykDe1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085112; c=relaxed/simple;
	bh=0yu4ETl3Llm6meiW3bSvhHnCccT0u36mpBWQkBT/rCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COyp3YMCjoH3dw0jdOudWdd3KwaxV1HtHb/VSskNTFTYnI8qK/W4hJJvOTF1fpEIuI9aG0G7CR2rTqsZMw8ReDGWs2VHql1YQjGePnauQy3C9AistIlHGVyCkf8L7Y5PNirqUWENETGIIhIHS0zGRbJghr8UyMROeNvAR9yrUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2oYiLFu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2oYiLFu"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8707005183so146801766b.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769085108; x=1769689908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckrawXIJKOLsw6LbWaTuoRg3rJ8DI/kVc35ulwhfiVo=;
        b=M2oYiLFuhLXkRoAtK+dv5kmcEGbrR2UKrds7B2duEFu7UISFwjBnD60z5WhSAIjuE5
         jdzHQ6nbe5HJmKlvJEROWeyMPV46L+9G+lz9MaTkX4GG1p9ihUDlVsN3aecxJpetAWoJ
         wiHHrpXOfqIZwYSnNBH3VFy7Mli1SqnZI4lAusojBqLGJJWdlZbefM40gupkTLoD8iED
         lj95to1zqp//0TZeDfccNv0b+LipXfTJx0yN0BsUKpDMiH0xchg0jW1WqNfwfn2Wyvpv
         gTyuVesYE7QkgpMEEu7SHDVCMpJ24b4Be182VRBpCNKd+7lbQljObJzQqQlSlNOi6Dfl
         WPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769085108; x=1769689908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckrawXIJKOLsw6LbWaTuoRg3rJ8DI/kVc35ulwhfiVo=;
        b=Qm7JLzS07J7VaUVtZZ1A0x/AAz66+C3x67cL+bZaiGQqdoFcsVH59Q0S7a3jy6vPnr
         jaaU7bPHyIQweKJxbxTRIklo0yB8/aKjC4YfFDM8ehIyViiDKiOZ/moihCJ4j7j9mvXE
         p+/FChq5awxmbx5d4U8BZoQapjhKYw+sHskbYHVimerbmeuQjzO97eKhrbcMTiai6NC0
         Zv+S8X8dvhT02TA/TG36gMe2kkz283CmhTg4hvfHxO2KiUB/0DJdb3creCuvP9xrOV87
         YIoWj5lp5NYPmUKOdwCq0sO0+K2MZBBgF4QH/ytmP4IqDwZrRv3fRzGTihbgssS9Kfyu
         vcpA==
X-Gm-Message-State: AOJu0Yw5CSyZLLkdJxIOXghcMsF33odBvpBFuy3yEXoTufnszPdZj1R8
	/om77TIyMnpV68yJigP0RoLFizu/ScN4xmhmzc7TrfYNfDuLKTvqdtIeyiHCcwDN/A==
X-Gm-Gg: AZuq6aIMPqLkjFZfPnq5gVoXNy5/LgSMxPif+ydMtfhGTr1ZrvzRBybdL7cDhj+MKaX
	xCxKGndpPQzNF+sXV+KIaEJZIWf2+KIuQeuboCPWTP7mUDXJacRR3W0A7fEtWuHteM07apsawqW
	WW3skuubf/lwnI0Z/DrLy04cdHrUVlAiY2ZqKS4EMzbW/V0uHw/fycTuafIJxiTMs0qzU2ZKFTV
	bdSWQe1UhfPZy8eHUPE+Voh/zB5DRS+CJX3iASwe9vXawP13p+ivDzHH7vv4BS4zgcF55JRzv8y
	WGOEAHGEYNukkSvZFM71ZdDmj9vAsFYHnAr3C7xSO6wkVZt79RfYXIc6D+/DrKgX49/pOzQ+Gui
	djq9zEvVsJj3RJCOxkFv0BQyDaiX9TeUtwa54a5vIkwyzXHVLe39SZW9e67NJ5fgkey7hmxWncZ
	LwoLLjBcFZtrKByM7dmU2ZsRhY+9Olw5q+OgryTADQWAwFs23BRWEKCw==
X-Received: by 2002:a17:907:9344:b0:b87:816f:34d7 with SMTP id a640c23a62f3a-b879327e454mr2040844966b.48.1769085108079;
        Thu, 22 Jan 2026 04:31:48 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a214e8sm1697278966b.60.2026.01.22.04.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:31:47 -0800 (PST)
Date: Thu, 22 Jan 2026 12:31:44 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
Message-ID: <aXIYsFwaov8SQczm@google.com>
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAPhsuW6B27WYpkT-ZY1wgBUNQknM9pKZm+oGk+bM_p33mVPx_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6B27WYpkT-ZY1wgBUNQknM9pKZm+oGk+bM_p33mVPx_A@mail.gmail.com>

On Wed, Jan 21, 2026 at 11:14:10AM -0800, Song Liu wrote:
> On Wed, Jan 21, 2026 at 5:54 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > Currently, the BPF cgroup iterator supports walking descendants in
> > either pre-order (BPF_CGROUP_ITER_DESCENDANTS_PRE) or post-order
> > (BPF_CGROUP_ITER_DESCENDANTS_POST). These modes perform an exhaustive
> > depth-first search (DFS) of the hierarchy. In scenarios where a BPF
> > program may need to inspect only the direct children of a given parent
> > cgroup, a full DFS is unnecessarily expensive.
> >
> > This patch introduces a new BPF cgroup iterator control option,
> > BPF_CGROUP_ITER_CHILDREN_ONLY. This control option restricts the
> > traversal to the immediate children of a specified parent cgroup,
> > allowing for more targeted and efficient iteration, particularly when
> > exhaustive depth-first search (DFS) traversal is not required.
> >
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> The code looks good to me.
>
> Some nitpick and some high level questions/ideas below

Sure, thank you for taking a look!

> >  enum bpf_cgroup_iter_order {
> >         BPF_CGROUP_ITER_ORDER_UNSPEC = 0,
> > -       BPF_CGROUP_ITER_SELF_ONLY,              /* process only a single object. */
> > -       BPF_CGROUP_ITER_DESCENDANTS_PRE,        /* walk descendants in pre-order. */
> > -       BPF_CGROUP_ITER_DESCENDANTS_POST,       /* walk descendants in post-order. */
> > -       BPF_CGROUP_ITER_ANCESTORS_UP,           /* walk ancestors upward. */
> > +       BPF_CGROUP_ITER_SELF_ONLY,              /* process only a single object. */
> > +       BPF_CGROUP_ITER_DESCENDANTS_PRE,        /* walk descendants in pre-order. */
> > +       BPF_CGROUP_ITER_DESCENDANTS_POST,       /* walk descendants in post-order. */
> > +       BPF_CGROUP_ITER_ANCESTORS_UP,           /* walk ancestors upward. */
> 
> Changes above seem unnecessary.

This is just noise, sorry. Will revert this once I send out v2.

> > +       /*
> > +        * Walks the immediate children of the specified parent
> > +        * cgroup_subsys_state. Unlike BPF_CGROUP_ITER_DESCENDANTS_PRE,
> > +        * BPF_CGROUP_ITER_DESCENDANTS_POST, and BPF_CGROUP_ITER_ANCESTORS_UP
> > +        * the iterator does not include the specified parent as one of the
> > +        * returned iterator elements.
> > +        */
> > +       BPF_CGROUP_ITER_CHILDREN_ONLY,
> >  };
> 
> [...]
> 
> > @@ -320,6 +332,7 @@ __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
> >         case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> >         case BPF_CGROUP_ITER_DESCENDANTS_POST:
> >         case BPF_CGROUP_ITER_ANCESTORS_UP:
> > +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> >                 break;
> >         default:
> >                 return -EINVAL;
> > @@ -345,6 +358,9 @@ __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *i
> >         case BPF_CGROUP_ITER_DESCENDANTS_POST:
> >                 kit->pos = css_next_descendant_post(kit->pos, kit->start);
> >                 break;
> > +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> > +               kit->pos = css_next_child(kit->pos, kit->start);
> > +               break;
> >         case BPF_CGROUP_ITER_ANCESTORS_UP:
> >                 kit->pos = kit->pos ? kit->pos->parent : kit->start;
> >         }
> 
> I wonder whether we can use the return values and/or the kfuncs to
> enable more flexible walks. For example, some return value means
> "do not walk more children, go back to the parent". This will enable
> use cases like "walk children and grandchildren nodes from here,
> but not any deeper". WDYT?

Some general control over whether the DFS traversal should continue in
a specific direction could be nice. That way you could reverse out of
a specific subtree/branch early without necessarily having to walk all
nodes under a given subtree/branch.

With the above said however, it's not really a control/semantic which
I'm after at this point. I'm purely interested in exhaustively
iterating children of a given parent before selectively deciding which
subtree/branch, and therefore parent, I'd like to explore next.
