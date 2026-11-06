Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793958090;
	b=o2ef14va8D0P4Fx+YAA2zGo39m2h/POdnJSNM/uS+JSl9F94/UJMFHjFpAdv07IgZX3e
	 ZDFJxvqT5P3CEN5hzsRTXPwnpfbw6/Lnc49ojXcNUQs2W1BtSTzr6UR5qML6sxCbMkhSF
	 abnkv3h8LIpiACfjcliazMMo+yL07iaOb9D9amK5XT/mqZawIFwRzGYt728QarjfFET8D
	 po7OCYWqK8ChldT2FRlaqGzQf10kgCTZhxHuWKWKgCfBeLGrVaWppxpWMuPsncz8PHrOu
	 GR1Jf5UOF5dfjKkJ2k15lHejYjmHXq0ldNFbyu8FLnn6YjRr4tcElg502Y8Vukc0WrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vZiV4xlllFgZ8pi2R3Ci53Ly2pk5TC1KMGzjsQrNXxc=;
	b=J2veMdW91pFpkuK7rBi8q7CI3SzxJoXrdWBrtQVBrThXF3to4/29kd6oXNp6ZfqKGEyc
	 esBgXMhjVMr818G7OBKGhA7KOVykp2vWAC09AnvT6crdDLYgVNiAsK0XUMLImc5IH6j9S
	 Jaz3GQt2jPMwUaIvooJkn+zb1m2l1BQ1N4X3nNOddjCfrMNvlctJ2A/AFxmxGDIyuHd4p
	 is4VOpT/EaY+CtQ3qF2PIs+jvJY7fCjeEXP1MHe5u+gT3py0NzmiJxqhY6u1CkmR2e6F4
	 apOhXXMjmm5o4rrGEPIRWAFbmZ+yjMrqWfL8swkeguv+tIrS0OJEarbYiWuCVdcOBJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ho5hVEJ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C8606D610
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B87C8606D610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ho5hVEJ1
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4877837890fso190762fac.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 01:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793958088; cv=none;
        d=google.com; s=arc-20260327;
        b=fh8cxGVOJalrwe7l603idDgs27neZGESMwBujcwykESRxhA6bf+I9rAsPqoQ4SSXYv
         Jh8tGsipjuYXJ58J/EDQ2E3XyN0i1wexMqn2ElR2MGlQVJfO3LiwYVxXPLo6c4qDFvbN
         jsd8iIxPOpnmUdH2r/XonpZB6Ha873aspNf5YRVg439C9kyQdb7DxWZy/cZ0svIeCRiM
         JEEeZAJpBdT2LzUUIrdsDKiJsNmb7s4sJKZd3nuvCdR9A+TUOucf30nzXUvTBBKemy71
         wylsU9kiXgvXymRFEjXnT1w/huYKwLUkQBXx3kS7Dm3MqV5bwI9aziUoqle4aaV1/kzp
         T6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vZiV4xlllFgZ8pi2R3Ci53Ly2pk5TC1KMGzjsQrNXxc=;
        fh=irkv7Aaz6eeXLiF4ZkE8uCD3K4lRRWawtDgMG88qBM0=;
        b=lmaMqtLKgFiyeh959cNSwH3niSXlSeZdaqSqpoE3OkLuTOYppa6CvRbTLuaERMRY9A
         rSSDyzQpx336QvHNsdls7YClS4Ln/mkQUDHUMKHAXJHe1u70pNfGvuWOmXjSneL2oKvX
         c5pduq0ozwzfW5mdhjveFYZUnLg2PFiPofAt+0UYnxG8aKxXkaNmgi7zuhrspPr6RDwS
         lWNO7flK1QoN/eUDDQ4BwYRuYbpgmUGcAAIFBKFRY1AT374rNz4/s5tzWl1mSIhhqGWP
         LFoNRdrL+uORBOCCykc22a2KdNsdzmOj0OsSu45h9H4q6tnueWa0HAtnaZyk5iOWwDng
         hkmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958088; x=1794562888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vZiV4xlllFgZ8pi2R3Ci53Ly2pk5TC1KMGzjsQrNXxc=;
        b=ho5hVEJ1CFnC0mISQg9mYFTTjAtTLSpD0+xGyrxgqxeczZjdj27inDCGOoEbSPlUXu
         wqBmunmS6r2JnaNFSLg5nU9+B0A6xXbMKqx01OxXu8tm/+RSVaNpYOJ9daHbLhjPPUKY
         SQHHRFcARCUa/mLODrk1orGcJ8boZ0qlonKgXKpco3tODEd+6M6XWh47g9HcyqSxTWqm
         Po7IS3lT8ksCK/aG8RKbCouYf3rPBiv15WpFAE5ctUnIEpwKmVltWDFXbS7RjKbc7xLC
         AwmOWTbEJf8c4RaxbVcPqW4yNlhKTn4THmlKAjC7A58A3Ed9nxcxJWk6ud3G41cQnn4f
         E/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958088; x=1794562888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZiV4xlllFgZ8pi2R3Ci53Ly2pk5TC1KMGzjsQrNXxc=;
        b=gD9gKWEVHtqlM8vIG/xX+0LuOvgmfCyqkI+X/l8rbBWF7wiACwN/EcKJyD5Sdd/Hlk
         Cv8mpemPj9y3S+6p025WNSy9QNxa/vFSAjNmGFja7gZQAl67VmCUAu9R6I6k54kfm7KJ
         793+sCh9/DTiuznYI4slgWtEx/iR0vr/9C6uN5U0oP0rRTOhPpMFKLzdwKCnmNNXx8cW
         jAQGbXTXE7nosmAk2V7PjaZQZJjSeX/ssyQIaTGhrfTQn76/oTQur110Q5/zei+PsCJm
         0LpHJByNzA4L9WH0YGAwCykas4+6egOhfQeKKdRYXmj3utxi+ZIcOSjjLKQ1i/mUGVOs
         czKA==
X-Forwarded-Encrypted: i=1; AKwUvBz0pC7bKgUmBWgIUJk9l0TK4q6SJ3DNDOwCYhlx0O2NCyJLdfYZrpbYurCD18dA2PP8n94=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IdHwZqGeZI1YqHXaEDtiPf5eZMALAGuUEwISzluU3cHojhkE0
	x7T+FrNBw5fQ5il3oDVbZPQsaN9KERMrn0c8pvWFmxfoBgA1qyFzgZlmS0qJnoTEEtqn8oAld7t
	/fh3FJnUcy6C23aNKObZscbdtt4LQI9Q=
X-Gm-Gg: AYBFou1YAf9NT7k8pL03UycOJdJK7vElLrhmMaYRHP0Gut9q+JB10s3I2kQGo3NcD1h
	ux5T6Lx6gcTPIus6HxBcf6sumnr0gA0N5UByBOGbscUZBVQ7MpfDfp0T4beMogi61OWH/v6WkJG
	hoaGMgKVZzLz2FpmS/acFy9bVv8x89KcUCvmR9EY1ji1yCCxQUWxvqhJMAhQ4hls4u2TnRjHgek
	rwe49ZqiQsk9qqGqWMpsVUKaCjynp7O/3rxmongHwEb6MdVIq+P5gEYdz6yWww82itUM6obzhHC
	ziTq5/Ui+Eb9JYPaVDbE6TEP7RbvI0R6qkqVc9c5GoGnw+FMi0bsdTAyXrf1tR0Opn7sIf0w8Q1
	NY6GCWCdzvb/gYOyd+A/Szec4k9vL4Qss/U1nav6r7Lorp4yZUuJZkb1SYPiLDn8Ls8o=
X-Received: by 2002:a05:6808:2218:b0:53b:ca1f:1850 with SMTP id
 5614622812f47-567e14d9f3bmr1311324b6e.28.1793958087837; Fri, 06 Nov 2026
 01:41:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103090651.35399-1-amaan.cheval@gmail.com> <autTTxuRQFF00PCy@boxer>
In-Reply-To: <autTTxuRQFF00PCy@boxer>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Fri, 6 Nov 2026 15:11:15 +0530
X-Gm-Features: AclHuK-2yUn1jSnEuql_2LE_FcOzEiz4V_deEBPCsZZLOAEB0rmiHCI36BmWN90
Message-ID: <CAG+wEg0nKvZvSiLD-J6kqttZyVSQTGu+_y3C623HsXRZxe6ZUQ@mail.gmail.com>
Subject: Re: [PATCH net v3] gve: leave refcount headroom in the RX page bias
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com, 
	przemyslaw.kitszel@intel.com, pkaligineedi@google.com, maolson@google.com, 
	csully@google.com, willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:16=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Nov 03, 2026 at 02:36:48PM +0530, Amaan Cheval wrote:
> > gve's GQI and DQO-QPL RX paths set every RX page's refcount to INT_MAX =
and
> > hand references to the stack by decrementing page_info->pagecnt_bias, t=
o
> > avoid an atomic op per packet. This leaves the page no headroom: while =
a
> > fresh page's buffer sits in an skb its refcount is already INT_MAX, so =
a
> > single get_page() from the stack wraps it negative.
>
> Hi Amaan,
>
> by headroom you mean here the space for additional refcount bumps? A bit
> confusing as my head tends to correlate 'headroom' with packet layout ;)

Yes, that's what I meant.
However, my head is inclined to agree with your head, thanks for the catch!
I'll reword it as "fix RX page refcount overflow from the pagecnt bias" in =
v4.

>
> one minor comment below.
>
> >
> > splice() of received TCP data into a pipe takes such a reference, and t=
he
> > onward splice into a socket then fails: skb_splice_from_iter() sees
> > page_count() < 1, sendpage_ok() fails and the send returns -EIO (since
> > commit 2e910b95329c ("net: Add a function to splice pages into an
> > skbuff for MSG_SPLICE_PAGES")). tee() of the pipe fails with -EFAULT vi=
a
> > try_get_page(). On GQI the reuse check gve_rx_can_recycle_buffer() also
> > sees page_count() < pagecnt_bias, WARNs and calls gve_schedule_reset(),
> > so a task that merely pins a fresh RX page (e.g. holds spliced data in
> > an undrained tee() pipe) can reset the NIC.
> >
> > Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do: the bias
> > only has to make the per-packet atomic rare, so a small value leaves
> > page_count() ample headroom below INT_MAX for the stack's references.
> > Refill by adding a fixed batch and setting the bias to it, which keeps
> > the rule `references =3D page_count() - bias` intact.
> >
> > Reproduced on gVNIC in GQI-QPL mode (GCE n2-standard-8, 6.12) and in
> > DQO-RDA mode (GCE c3-standard-8, 6.12, where DQO-RDA still uses the
> > bias) with the help of relay.py -- a small splice(2) TCP proxy --
> > relaying a download while the RX ring is refilled with fresh pages:
> >
> >   ethtool -G eth0 rx 512 && ethtool -G eth0 rx 1024   # fresh RX pages
> >   ./relay.py $HOST 8080 &                             # splice()s both =
ways
> >   for i in $(seq 200); do curl -so /dev/null \
> >       --connect-to $HOST:80:127.0.0.1:8080 http://$HOST/file; done
> >
> > Most downloads failed with EIO before the fix (tee() with EFAULT) and
> > all completed after it. relay.py is at the Link below.
> >
> > This bug was found and fixed with the help of an AI coding assistant
> > (Claude Code) over an interactive session; it read the driver and
> > splice/pipe code and ran the tests above.
> >
> > Link: https://github.com/amaanc/kernel-bias
> > Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
> > Fixes: 58401b2a46e7 ("gve: Add rx buffer pagecnt bias")
> > Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx pat=
h")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Tested-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
> > ---
> > v3:
> >  - Refill when the bias reaches 0 again, as in v1. DQO-QPL is not
> >    supposed to support XDP at all, and it will be blocked explicitly in
> >    a separate patch, so the v2 refill-at-1 change is not needed.
> >  - Added Reviewed-by and Tested-by from Harshitha Ramamurthy.
> > v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@=
gmail.com/
> >  - Refill when the bias reaches 1 instead of 0 so the driver keeps a
> >    reference of its own across every handoff. At bias 0 a consumer that
> >    returns its reference synchronously, such as an AF_XDP socket in cop=
y
> >    mode on an XDP_REDIRECT from DQO-QPL, freed a page still registered =
in
> >    the QPL.
> >  - Commit message: explain the refill point, drop the build notes.
> >  - Re-tested on 6.12.113 (c3-standard-8, DQO-RDA, which still uses the
> >    bias on 6.12): no EIO/EFAULT from splice/tee and no NIC reset after
> >    applying the patch. DQO-QPL is untested; I have no access to that
> >    hardware.
> > v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheva=
l@gmail.com/
> >
> > Built allmodconfig W=3D1, no new warnings.
> >
> >  drivers/net/ethernet/google/gve/gve.h                |  2 +-
> >  .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
> >  drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
> >  drivers/net/ethernet/google/gve/gve_utils.c          | 12 +++---------
> >  drivers/net/ethernet/google/gve/gve_utils.h          |  8 +++++++-
> >  5 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethern=
et/google/gve/gve.h
> > index b7ce6e8632db..18d7edbf4b3b 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -119,7 +119,7 @@ struct gve_rx_slot_page_info {
> >       void *page_address;
> >       u32 page_offset; /* offset to write to in page */
> >       unsigned int buf_size;
> > -     int pagecnt_bias; /* expected pagecnt if only the driver has a re=
f */
> > +     u16 pagecnt_bias; /* expected pagecnt if only the driver has a re=
f */
> >       u16 pad; /* adjustment for rx padding */
> >       u8 can_flip; /* tracks if the networking stack is using the page =
*/
> >  };
> > diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/dr=
ivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > index 6880d1531ba5..571f851d6dcd 100644
> > --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > @@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
> >       buf_state->last_single_ref_offset =3D 0;
> >
> >       /* The page already has 1 ref. */
> > -     page_ref_add(buf_state->page_info.page, INT_MAX - 1);
> > -     buf_state->page_info.pagecnt_bias =3D INT_MAX;
> > +     page_ref_add(buf_state->page_info.page, GVE_PAGECNT_BIAS - 1);
> > +     buf_state->page_info.pagecnt_bias =3D GVE_PAGECNT_BIAS;
> >
> >       return 0;
> >  }
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/eth=
ernet/google/gve/gve_rx.c
> > index 81ea800e66e9..6533fff06155 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx.c
> > @@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring =
*rx,
> >       page_info->buf_size =3D rx->packet_buffer_size;
> >       *slot_addr =3D cpu_to_be64(addr);
> >       /* The page already has 1 ref */
> > -     page_ref_add(page, INT_MAX - 1);
> > -     page_info->pagecnt_bias =3D INT_MAX;
> > +     page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> > +     page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> >  }
> >
> >  static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *d=
ev,
> > @@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring =
*rx,
> >                       rx->qpl_copy_pool[j].buf_size =3D rx->packet_buff=
er_size;
> >
> >                       /* The page already has 1 ref. */
> > -                     page_ref_add(page, INT_MAX - 1);
> > -                     rx->qpl_copy_pool[j].pagecnt_bias =3D INT_MAX;
> > +                     page_ref_add(page, GVE_PAGECNT_BIAS - 1);
> > +                     rx->qpl_copy_pool[j].pagecnt_bias =3D GVE_PAGECNT=
_BIAS;
> >               }
> >       }
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/=
ethernet/google/gve/gve_utils.c
> > index caed38cd5f2b..cb6fba3122d5 100644
> > --- a/drivers/net/ethernet/google/gve/gve_utils.c
> > +++ b/drivers/net/ethernet/google/gve/gve_utils.c
> > @@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_in=
fo *page_info)
> >  {
> >       page_info->pagecnt_bias--;
> >       if (page_info->pagecnt_bias =3D=3D 0) {
> > -             int pagecount =3D page_count(page_info->page);
> > -
> > -             /* If we have run out of bias - set it back up to INT_MAX
> > -              * minus the existing refs.
> > -              */
> > -             page_info->pagecnt_bias =3D INT_MAX - pagecount;
> > -
> > -             /* Set pagecount back up to max. */
> > -             page_ref_add(page_info->page, INT_MAX - pagecount);
> > +             /* Out of bias: take another batch of references. */
> > +             page_info->pagecnt_bias =3D GVE_PAGECNT_BIAS;
> > +             page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
> >       }
> >  }
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/=
ethernet/google/gve/gve_utils.h
> > index bf2e9a0adb36..316f97607351 100644
> > --- a/drivers/net/ethernet/google/gve/gve_utils.h
> > +++ b/drivers/net/ethernet/google/gve/gve_utils.h
> > @@ -25,7 +25,13 @@ struct sk_buff *gve_rx_copy_data(struct net_device *=
dev, struct napi_struct *nap
> >  struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct=
 *napi,
> >                           struct gve_rx_slot_page_info *page_info, u16 =
len);
> >
> > -/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. =
*/
> > +/* Up-front references gve holds on an RX page, so handing a buffer to=
 the
> > + * stack is a pagecnt_bias decrement, not a get_page(). Keep it in a u=
16 so
> > + * the 32-bit page refcount keeps the headroom every page needs below =
INT_MAX.
> > + */
> > +#define GVE_PAGECNT_BIAS USHRT_MAX
>
> IMHO code would be more readable with plain USHRT_MAX usage then you know
> immediately what value is being used. Other drivers do so at least.
>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Makes sense, I'll use USHRT_MAX directly in v4.
Thanks for the review and tag!

>
> > +
> > +/* Decrement pagecnt_bias. Top it up by GVE_PAGECNT_BIAS if it reached=
 zero. */
> >  void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
> >
> >  void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
> >
> > base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
> > --
> > 2.47.3
> >
> >
