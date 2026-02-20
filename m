Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06321DFD8B
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555510; cv=pass; b=D1ehBgb5ttG8u/e7l8rJwyeuVQFtJ7knjMO6ntqkeUSDE/aIC/SnsmrHvL1NkxaGMiU6umK6F2dw89LJDf5NY2tPNOPIk796FQeRLK6/GTD7ya7OM6/WpCS4vApDyN10q9DXsY0qT2pRFrzZdYJtKdCT4QV/ML2SfBQ/ZazSee8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555510; c=relaxed/simple;
	bh=SBxQIuxdianCCp23hxjDBvPBJ4E8gh2doTeLXvNUrJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHsn4xXqQR02dSzAmqMLAFCV4BhhugbnGECwpKSyoCfM+TLyfvPqSnNhX0K3NY2D0lDAEXUV05uBnbucwMNmhQ+hUqi0LWCXeQeBiuSpQe1OH6Lw2rVhYMQLJnpiNkpUrMI0ruEfmfLTb8X6W8FgkhlHkMfSbl/MPu4yK62OitM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE+wQMTZ; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE+wQMTZ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359108fd24so976253f8f.2
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771555507; cv=none;
        d=google.com; s=arc-20240605;
        b=k3xRB43iUxnAdftXtfjQV6e3dCu+Q15hSqBTzb7ftn3JKq7dgF/WulNOWSX72W3u8Y
         OfsijrnZHqoXsGoe/U2Lx+tTI4iXEwxMC0C/Lms7YRRMXbCMyWz2EqY7EHRtajqRo9Fe
         nQP9SxId+SyDZYgwxhW+8QJCcU6oiGx4bNyXvq1R2t1Hm8diuvtBHQBE1sEeRSpiJQ1P
         u6x0UJ6lGJCzkTKUdKgZti5WRz0RW9u956G8tkP+KFE3y/gKa52fDfVVTjbxCXNSCPS+
         syVIOFUxN5uPwMcH1uinbnYsXnLRo0G184tBWImnOyGXRsvbY6MaTRmzSFkzKkevyL4/
         7lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4XnDZ3zmMGkSK9IywzENGPPeHxiXcxzEzhSIqVZkZE=;
        fh=QA9NjzbzaB7iCIf3Cki/AoHSQyYt/80LbdCaaTRtcrc=;
        b=aNUmgs8wFPR9K12nB8xE7Pwwy79xF7MSq5JqDlgF75IoOHl1YCiFlwq4qfK6GmDoFa
         cUCzN6RvOmYwpG2dlTFn9vt/sDHhHWVXXebxA//7QwGiyFMApU9/amekSjYt02sG+QhX
         LXEr2DkLuDVTsjbWkiB/JyUsllws7ekHT4gYU11EhquNcC6UKB4oKfe/zLvBBrxmFQV+
         q/Y14yf6jBOxxTCle6VvcoUxxxrey3mYVf2q2xLUd9joNJMECsA6a/KbUz2m1CtAohJ6
         fXgq993c/AowUWXxSPEFNjUMYZjz9MDyd1jinEvIlKAe/n3B3dPqyEBWWmP+5dK8RJ+3
         BNKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771555507; x=1772160307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4XnDZ3zmMGkSK9IywzENGPPeHxiXcxzEzhSIqVZkZE=;
        b=YE+wQMTZRp2BSx/fKi5b57/OtiuqIdnrBuwGfxKP1g18CPE6Yoxe36n4W2YppGcZV0
         Yz27v+VAVWir6ZHpgiNlfO/972HofUx/3uZLFZQC3apJc64bkijDpdFfifejyGqZEdw5
         fPWyqNl0iidcc5FZwP93mHLFhYutxUA5hwqUHEzxrl+GqJFE44nOIw08OeYZjzo15p+C
         om+MgJ62vP9gRAhwbTTOzAqZO4yQfSuoy656VvkGN3sJ8/LMeYUhWUoZXSQ3fNQoNvLe
         BF5wnjGwyhnQeHtNumOyAMViRbyrtbQQs54GXz9Wim6QD86FskZqBdOJmXHtnjtIUPdi
         bt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771555507; x=1772160307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4XnDZ3zmMGkSK9IywzENGPPeHxiXcxzEzhSIqVZkZE=;
        b=S7VsIq/CCawqw4S8EFVj1PPEpvDNfvQ4tyADGEezX5XOrNXVGSifPEFe/A0v2uPZLE
         AyIW4ucQ70Y003LHdxlGvgs/u302qkR/dND5Twmg8GF7T5ELNkLzZ6KrlmkiTf/q+X0a
         YhXl8nRxwmM3D9xVnxW2K4eGlwhGtp3gGHek0uWHAPKqN1kTsMv9oTULePhqEDBlBjth
         87BABDR0SwfW9yqTj0lsJUcZL1Ff7YD1aXRZqTSCnlzot7jZVpK1bx9u6j4iIsOVALGY
         8OJZP2/8E6F40JFbbNa3ubVH/eTTomoRFnHR3bJVPG08al5imA3qP4Gqwbczi7fhoYuu
         JVew==
X-Forwarded-Encrypted: i=1; AJvYcCVJGvQLZ0T631OdpCtvcvMGlWHnJM8kICB5thHrVUOirMFjOijghbADL5Hwd0HoRnONuhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8xZ88kvgFMhRNOKVvsyBNaIuBFUpntxOUkOhSDkPyGn8pMdP
	akcrnKR5tgLr2oSF6x+MVBd0aCo8kOHMR7Ye9N8bn8qFKBHCQO0903p6j8ErBoawg7pL81shMos
	cbh3Q3TlnhhuyC/24yuVy2+TiNJHkGKQ=
X-Gm-Gg: AZuq6aLSS5+jZYs/QUGNwK+/iZb8ieYaPhPLuHDKHyoXe/d3qIvXiuW15aBQd3oeiqR
	1zIY6ve0Rx1isq4oGeW3d4GIUPGNe+lUzsF4WLlHDtD7XRKzFrKeVSuKZHGEZxZGfEIztwC8VN8
	SBGN8Qh9l8YKV+KPc7MOQ68dPI7RobPZFv+bdZSdBUKMCzswUgC+hOVLC3XFjs/OdWjWyU/sv2F
	ioI5mv7c6fjSVGq7FwnGwUcN0+bDf3VvyB11CYHKuc9ZwfMeTXxJWGZHLS4PyX8BJeqp8NWaTAi
	6xRdTg/D0GZe4qs5SjoZ4K+ashEcXGG67N1ah8kMMZqjEChL5+IWQk1DU8i4zhryzN3ri6lgY1n
	sfm8aOHlvE4Wlfr3hXYsyQzkmGRukME9O7wf8
X-Received: by 2002:a05:6000:40d9:b0:437:70d3:44e7 with SMTP id
 ffacd0b85a97d-4395fd5674amr8175315f8f.30.1771555506943; Thu, 19 Feb 2026
 18:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216201428.65641-1-kohei@enjuk.jp>
In-Reply-To: <20260216201428.65641-1-kohei@enjuk.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 18:44:56 -0800
X-Gm-Features: AaiRm52M2ZhyERA5MfSVbNahK0U1WI9kgHu0DTPC7VUtQG0QZWXC2HYB6Mxd4gg
Message-ID: <CAADnVQL4F10BxRHp_-inKpHbDuZZ-aXsAOuLZL-k7aGaM0zBbA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
To: Kohei Enju <kohei@enjuk.jp>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jussi Maki <joamaki@gmail.com>, 
	kohei.enju@gmail.com, syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 12:15=E2=80=AFPM Kohei Enju <kohei@enjuk.jp> wrote:
>
> get_upper_ifindexes() iterates over all upper devices and writes their
> indices into an array without checking bounds.
>
> Also the callers assume that the max number of upper devices is
> MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> but that assumption is not correct and the number of upper devices could
> be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> stack-out-of-bounds write.
>
> Add a max parameter to get_upper_ifindexes() to avoid the issue.
>
> To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
> an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
> Then send a packet to the device to trigger the XDP redirect path.
>
> Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@goo=
gle.com/T/
> Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device=
")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  kernel/bpf/devmap.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de76e..cdc4299a5955 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -588,16 +588,18 @@ static inline bool is_ifindex_excluded(int *exclude=
d, int num_excluded, int ifin
>  }
>
>  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> - * least MAX_NEST_DEV elements.
> + * least 'max' elements.
>   * Returns the number of ifindexes added.
>   */
> -static int get_upper_ifindexes(struct net_device *dev, int *indexes)
> +static int get_upper_ifindexes(struct net_device *dev, int *indexes, int=
 max)
>  {
>         struct net_device *upper;
>         struct list_head *iter;
>         int n =3D 0;
>
>         netdev_for_each_upper_dev_rcu(dev, upper, iter) {
> +               if (n >=3D max)
> +                       break;
>                 indexes[n++] =3D upper->ifindex;
>         }
>         return n;
> @@ -615,7 +617,9 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, str=
uct net_device *dev_rx,
>         int err;
>
>         if (exclude_ingress) {
> -               num_excluded =3D get_upper_ifindexes(dev_rx, excluded_dev=
ices);
> +               num_excluded =3D
> +                       get_upper_ifindexes(dev_rx, excluded_devices,
> +                                           ARRAY_SIZE(excluded_devices) =
- 1);

No need to reformat. 100 char is ok.

Jesper, Toke, pls review.

pw-bot: cr
