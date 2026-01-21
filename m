Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E2378D62
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022863; cv=none; b=Vrx/0a4GtWYZoXtd74YxJPE7FQKR2/wQPkkop3aDgUn2ueCT7l4LGq/m83OJr5V3OeKy2gidqRFOgAtYq6zuxQyC0eN29BWELHMu25pP3B6tmgdUFsV5lScUQuyKV6BiSbGo9kJZvSxvDZww3kjOlmdornQubwNK6uIni6JehLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022863; c=relaxed/simple;
	bh=b/KuOWOWxlSyrCXUXIuBotvcweFTf4xbWf6NYPxk69U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElZFGIr13uH9Gc9d+V13sMLkXqdnOkepKvBSLoDeYAhNj1FeJqB/edoaw7D2N/vhtNssa0whLrIi+EO2lnTf8zco0qGoBBvwHbvMrMspWNGUIRLjL6EVHIgOzkNOIOPyuLZSh0AKF33teWUKSIbfBcPsqU7zTIYr1LHTKlFTwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRSr5JEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRSr5JEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B87C19422
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769022862;
	bh=b/KuOWOWxlSyrCXUXIuBotvcweFTf4xbWf6NYPxk69U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KRSr5JEeLU31pmIJaG7S1BT0z9cUAsa9M07Vfsf1Mg1LVXp38VBqr6MczeVMpbrbr
	 wyFM0zHYaijSA60yq+jkzL1HJ9+3oTu7rn6/+xWDWg3HjnM7MU19kRewYH+sv/702e
	 fA/saF+wTzS90lj4G2xYrdUvg5pT3txTZPOy12+GOA5wiVjIMJEEbRECRME4jrUx9A
	 BNp5VkYesIUveE6BDTRchq9FDeKnyYBgnX0jHXQ1npzEQG1si83ixAl1j+uip76ev/
	 pxnOfEe1qx6KtvNVjH/lO/hSpL+ueWR3j9GwmVIPD56FyE0ZGpCDNrxbq8J8fP53SF
	 h6kznGyhrBE6Q==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50146483bf9so1440371cf.3
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 11:14:22 -0800 (PST)
X-Gm-Message-State: AOJu0Yz5QCbY/ueG7w2Sfq93B42TIYykhJFivo/n51jEtboDbM72SYyy
	AlSpibYahZLxrXpVGUrBjcy8VxOpHhwgykJH4+mDkyEQTuNthhYWDoD3VuyEDt1Eo+qPLDFWGny
	ENk5q2xh7BETeAtrskY90n2ItkGQS8ao=
X-Received: by 2002:ac8:5e49:0:b0:501:b1d8:6376 with SMTP id
 d75a77b69052e-502a175951dmr267000051cf.76.1769022861809; Wed, 21 Jan 2026
 11:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121135444.187001-1-mattbobrowski@google.com>
In-Reply-To: <20260121135444.187001-1-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 21 Jan 2026 11:14:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6B27WYpkT-ZY1wgBUNQknM9pKZm+oGk+bM_p33mVPx_A@mail.gmail.com>
X-Gm-Features: AZwV_Qi2_F906JHvcKo3bD5Bf84meQFB85GuO1ZlYed6HTLSIr7UZj1yok71YNY
Message-ID: <CAPhsuW6B27WYpkT-ZY1wgBUNQknM9pKZm+oGk+bM_p33mVPx_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 5:54=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Currently, the BPF cgroup iterator supports walking descendants in
> either pre-order (BPF_CGROUP_ITER_DESCENDANTS_PRE) or post-order
> (BPF_CGROUP_ITER_DESCENDANTS_POST). These modes perform an exhaustive
> depth-first search (DFS) of the hierarchy. In scenarios where a BPF
> program may need to inspect only the direct children of a given parent
> cgroup, a full DFS is unnecessarily expensive.
>
> This patch introduces a new BPF cgroup iterator control option,
> BPF_CGROUP_ITER_CHILDREN_ONLY. This control option restricts the
> traversal to the immediate children of a specified parent cgroup,
> allowing for more targeted and efficient iteration, particularly when
> exhaustive depth-first search (DFS) traversal is not required.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

The code looks good to me.

Some nitpick and some high level questions/ideas below

>  enum bpf_cgroup_iter_order {
>         BPF_CGROUP_ITER_ORDER_UNSPEC =3D 0,
> -       BPF_CGROUP_ITER_SELF_ONLY,              /* process only a single =
object. */
> -       BPF_CGROUP_ITER_DESCENDANTS_PRE,        /* walk descendants in pr=
e-order. */
> -       BPF_CGROUP_ITER_DESCENDANTS_POST,       /* walk descendants in po=
st-order. */
> -       BPF_CGROUP_ITER_ANCESTORS_UP,           /* walk ancestors upward.=
 */
> +       BPF_CGROUP_ITER_SELF_ONLY,              /* process only a single =
object. */
> +       BPF_CGROUP_ITER_DESCENDANTS_PRE,        /* walk descendants in pr=
e-order. */
> +       BPF_CGROUP_ITER_DESCENDANTS_POST,       /* walk descendants in po=
st-order. */
> +       BPF_CGROUP_ITER_ANCESTORS_UP,           /* walk ancestors upward.=
 */

Changes above seem unnecessary.

> +       /*
> +        * Walks the immediate children of the specified parent
> +        * cgroup_subsys_state. Unlike BPF_CGROUP_ITER_DESCENDANTS_PRE,
> +        * BPF_CGROUP_ITER_DESCENDANTS_POST, and BPF_CGROUP_ITER_ANCESTOR=
S_UP
> +        * the iterator does not include the specified parent as one of t=
he
> +        * returned iterator elements.
> +        */
> +       BPF_CGROUP_ITER_CHILDREN_ONLY,
>  };

[...]

> @@ -320,6 +332,7 @@ __bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css =
*it,
>         case BPF_CGROUP_ITER_DESCENDANTS_PRE:
>         case BPF_CGROUP_ITER_DESCENDANTS_POST:
>         case BPF_CGROUP_ITER_ANCESTORS_UP:
> +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
>                 break;
>         default:
>                 return -EINVAL;
> @@ -345,6 +358,9 @@ __bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_=
next(struct bpf_iter_css *i
>         case BPF_CGROUP_ITER_DESCENDANTS_POST:
>                 kit->pos =3D css_next_descendant_post(kit->pos, kit->star=
t);
>                 break;
> +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> +               kit->pos =3D css_next_child(kit->pos, kit->start);
> +               break;
>         case BPF_CGROUP_ITER_ANCESTORS_UP:
>                 kit->pos =3D kit->pos ? kit->pos->parent : kit->start;
>         }

I wonder whether we can use the return values and/or the kfuncs to
enable more flexible walks. For example, some return value means
"do not walk more children, go back to the parent". This will enable
use cases like "walk children and grandchildren nodes from here,
but not any deeper". WDYT?

Thanks,
Song
