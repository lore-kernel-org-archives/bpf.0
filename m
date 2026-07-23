Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC4335091;
	Thu, 23 Jul 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816135; cv=none; b=hhtrvvpTqZ0kNVuAZjZdIvHAL8IaDIw/G1lxBQWPvC+QJXSnsz4ehGsaqibVH5fxIIG5h8qyhgw4FA6tWgDHXRXZXgFSFyUnSKIzMiMl1T0sTcZIK4GL+fW8tPMpG4m+GtwBXWsuJ3ZwzTww0PFMtQdNZ6DvpxNOngaR91MzMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816135; c=relaxed/simple;
	bh=YBdMOKlaxYPP3hAbNP+AKxIXv6UQLudffOjgdGMDzEM=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=XVOYuSR3Ck/Pn2uns/CCBzDQowuhSUTdLTDm4HRd8Vyw7XS2OfrT54Ha/HOH6HNTG+/6ST+xzCHBZKPFCHVoq0BnFRc9hmTO8z6I+Gli/pI19BQ8vSWgxvGzfLT36F9NhMpqPtTGcUW+tWrkhv+JCh7lu2GgjXr1dxn5QlVGD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TBJDJT0g; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TBJDJT0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784816116; bh=m1fW/c2PDUMowmUABq2xRwXNu/N/GpGaTHQUB67TifI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=TBJDJT0gKl3VohwW8rBYsSG0cP+YmYSu75Z8EZiPo8HtQ3FX/1BzMiRY0mJHgVL7v
	 Ns3/AEZNFAcWxD8bVYTwDMlI1vGc97YWymGFKjewZvzmIc5SSj94NVsdLT384ttv9Z
	 WwPd6qNanQ7A4g1UgwQCZiU6zwua6oLpqtAzyc/E=
Received: from smtpclient.apple ([2408:8207:4821:550:885e:19b:2870:12b6])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 3CD3A8D6; Thu, 23 Jul 2026 22:15:13 +0800
X-QQ-mid: xmsmtpt1784816113tqfnul1oe
Message-ID: <tencent_0695E317AE6D8C40C848E31E1FB420937606@qq.com>
X-QQ-XMAILINFO: OATpkVjS499umLBCGK89N7O1z6b2nDgRBsBxG2Zlai/ohwdiVzjDtoFAtCyHys
	 i6Pml8Thy/69RWMwELyGEY/6pBCYjebdcXc3M9451Qiq4+MjZbcGrJ2iREHUxLZgtPfsmE+3CbaJ
	 +sWhwBKeOyTlNCdm3vOvv2pJC6U6FuPEaeHE8NWuXjNkScx37cJCGcZH+yxSSW9FY/NE73o7/8JB
	 pAghryQj8vm+ZNioDhuk3d3L32uAqQHuNnlEoDsI6+/sHLdk22zCk8WWyBbNooMDUA1F3KwSbFNQ
	 tTV793Dnq/9aHvELBSBLhvy1e8JGlBeCntChcVYG5lVN+IS5/5XhT/T2T6aykdXtRPrmpVzlk6oj
	 oBSRHVY79nvzs6EGOCyRbH614gf2Hjbync9snrkSDtsw1COSWErI5pYEmPEKTqNS7JkiXGKwDvWP
	 N0EBjiYoztuNmli318e1lVfV8Ei8Bnqd+C2lkDlv3ZOixSFKZg8ahlRxpUoBT2DZUYS0O6hskv0D
	 QQkq7R4Dzz47PqHWHFZ4f1NjbUi0YneDOhbMxfelajIoMeY2q9XJMAm6npnE+JD9Stcnkdke0hMY
	 9lxQEALMxVpJcEuO0Cf3nZHRFgmJHMJ2yy5wi3mK5PCTpkBIqaxMhfrS18SwPPO4vtyQKWfmRAyo
	 G3SZh8a7/A+ZIayQE023n9DbuFgxuUQN1IUvEpxYSP7KPNFyj8K8t+NnmGr1lkyrlHNMkSLqaS+T
	 mP/QyTH/gtGNb/IxnbarSvu9Hw4U3xTy3pNaRvuk2Y/7DnouzMZxxXSq7PU/fZ+aUu2Ip+nr70iD
	 NF5LQGUacKxIxZoSKdhayqAwSsOXYU8NytHzfDgT3NEBQZF4bRRq9Aoe0bymaen99B0J9dWkveAQ
	 C2odT1o9xnlG8BCKtCRGU7z14YVR+2syNLV89GGzthVGvvcVDCgOFDCBT1IX5JYzUldQJ1L1AAy2
	 DDVMfUhfKsXQ+ttk8X2Y+ToXd8o9ssHjTyqmQrFaJ4E8RLiXbj3P8CBRBrcJGQNJ3EdFElayNVLH
	 rG2NK755vkCi53VximoeuC7z1RYJlfg5TWfJ28gTNCFnK5oZQFA7t3SlBxadQVZOF9RyrhDoXbC8
	 f5D0ZF7OXqt+WOGRs=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next 1/2] net: atlantic: free stranded TX buffers on
 ring deinit
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <CAHS8izPBvv4ENCcnSpsbcL9+TEMj9nBE6CAj4fg9_aDBdhrBaQ@mail.gmail.com>
Date: Thu, 23 Jul 2026 22:15:02 +0800
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <D1E4B33D-35C7-4F10-A04E-D56A68FA11BC@cyyself.name>
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com>
 <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
 <CAHS8izPBvv4ENCcnSpsbcL9+TEMj9nBE6CAj4fg9_aDBdhrBaQ@mail.gmail.com>
To: Mina Almasry <almasrymina@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On 23 Jul 2026, at 02:29, Mina Almasry <almasrymina@google.com> wrote:
>=20
> On Thu, Jul 9, 2026 at 10:41=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> =
wrote:
>>=20
>> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
>> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors =
and
>> stops at hw_head, which no longer moves once aq_vec_stop() has =
stopped
>> the hardware and NAPI. Completed descriptors beyond the budget and
>> everything still posted in [hw_head, sw_tail) keep their skb or
>> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
>> the buffer ring and the references are lost for good.
>>=20
>> Today this is a silent memory leak on every interface down under
>> TX/XDP_TX load. With the following conversion of the RX path to
>> page_pool it becomes much more visible: XDP_TX frames carry fragment
>> references on the RX ring's page_pool, so a single stranded frame
>> keeps the pool's inflight count above zero forever. =
page_pool_destroy()
>> then never completes, the pool is leaked together with its pages, and
>> "page_pool_release_retry() stalled pool shutdown" is warned every 60
>> seconds from that point on, on every ifdown, XDP detach or ring =
resize
>> under XDP_TX load.
>>=20
>> Bring back aq_ring_tx_deinit() as it was before the removal and use =
it
>> for teardown again, with one extension: TX rings can hold xdp_frames
>> nowadays, so release those too. They are returned with
>> xdp_return_frame() since this runs in process context.
>>=20
>> Fixes: eb36bedf28be ("net: aquantia: remove function =
aq_ring_tx_deinit")
>> Assisted-by: Claude:claude-fable-5
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>=20
> Looks fine as far as I can tell, but don't you want this sent to net =
as a fix?
>=20
>> ---
>>=20
>> Notes:
>>    Without this fix, converting the RX path to page_pool (next patch)
>>    turns the stranded XDP_TX frames into leaked page_pool fragments, =
so
>>    page_pool_destroy() can never drain and the shutdown stalls =
forever.
>>=20
>>    Reproduced on an AQC100 with this patch dropped from the series =
(i.e.
>>    page_pool applied without the tx-deinit fix):
>>=20
>>      # reflect received frames back out through XDP_TX
>>      xdp-bench tx enp99s0                    # or any trivial XDP_TX =
prog
>>      # from a peer on the same link, flood RX so frames are in =
flight, then
>>      ip link set enp99s0 down
>>=20
>>    The pool is destroyed with frames still stranded on the TX ring, =
and
>>    page_pool_release_retry() warns every 60s with the same id and =
inflight
>>    count and a growing age, indefinitely:
>>=20
>>      [161110.753385] page_pool_release_retry() stalled pool shutdown: =
id 361, 12 inflight 60 sec
>>      [161171.170756] page_pool_release_retry() stalled pool shutdown: =
id 361, 12 inflight 120 sec
>>      [161231.588685] page_pool_release_retry() stalled pool shutdown: =
id 361, 12 inflight 181 sec
>>      [161292.005886] page_pool_release_retry() stalled pool shutdown: =
id 361, 12 inflight 241 sec
>>=20
>>    With this patch the stranded buffers are freed at deinit, inflight
>>    drops to zero and the pool drains cleanly.
>>=20
>> .../net/ethernet/aquantia/atlantic/aq_ring.c  | 30 =
+++++++++++++++++++
>> .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
>> .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
>> 3 files changed, 32 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c =
b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
>> index 8ff07de2bd52..c59b6c0b37f1 100644
>> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
>> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
>> @@ -360,6 +360,36 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>>        return !!budget;
>> }
>>=20
>> +void aq_ring_tx_deinit(struct aq_ring_s *self)
>> +{
>> +       if (!self)
>> +               goto err_exit;
>=20
> return; here and delete label?

Maybe I can change it in the next revision.I would this fixes to be more =
like a revert of commit eb36bedf28be
("net: aquantia: remove function aq_ring_tx_deinit"), so I would
like to keep that.

Maybe I can change it in the next revision.

Thanks,
Yangyu Chen

>=20
>> +
>> +       for (; self->sw_head !=3D self->sw_tail;
>> +               self->sw_head =3D aq_ring_next_dx(self, =
self->sw_head)) {
>> +               struct aq_ring_buff_s *buff =3D =
&self->buff_ring[self->sw_head];
>> +               struct device *ndev =3D aq_nic_get_dev(self->aq_nic);
>> +
>> +               if (likely(buff->is_mapped)) {
>> +                       if (unlikely(buff->is_sop)) {
>> +                               dma_unmap_single(ndev, buff->pa, =
buff->len,
>> +                                                DMA_TO_DEVICE);
>> +                       } else {
>> +                               dma_unmap_page(ndev, buff->pa, =
buff->len,
>> +                                              DMA_TO_DEVICE);
>> +                       }
>=20
> I would remove the unlikelys that seem unnecassry to me. This is a
> reconfig path and the unlikely is probably not improving perf.
>=20
>> +               }
>> +
>> +               if (unlikely(buff->is_eop)) {
>> +                       if (buff->skb)
>> +                               dev_kfree_skb_any(buff->skb);
>> +                       else if (buff->xdpf)
>> +                               xdp_return_frame(buff->xdpf);
>> +               }
>> +       }
>> +err_exit:;
>> +}
>> +
>> static void aq_rx_checksum(struct aq_ring_s *self,
>>                           struct aq_ring_buff_s *buff,
>>                           struct sk_buff *skb)
>> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h =
b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
>> index a70b880ada67..6431cc62962f 100644
>> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
>> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
>> @@ -202,6 +202,7 @@ void aq_ring_update_queue_state(struct aq_ring_s =
*ring);
>> void aq_ring_queue_wake(struct aq_ring_s *ring);
>> void aq_ring_queue_stop(struct aq_ring_s *ring);
>> bool aq_ring_tx_clean(struct aq_ring_s *self);
>> +void aq_ring_tx_deinit(struct aq_ring_s *self);
>> int aq_xdp_xmit(struct net_device *dev, int num_frames,
>>                struct xdp_frame **frames, u32 flags);
>> int aq_ring_rx_clean(struct aq_ring_s *self,
>> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c =
b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
>> index 2f9033ceed8c..05814fea0f5f 100644
>> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
>> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
>> @@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
>>=20
>>        for (i =3D 0U; self->tx_rings > i; ++i) {
>>                ring =3D self->ring[i];
>> -               aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
>> +               aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
>>                aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
>>        }
>>=20
>> --
>> 2.47.3
>>=20
>>=20
>=20
>=20
> --=20
> Thanks,
> Mina


