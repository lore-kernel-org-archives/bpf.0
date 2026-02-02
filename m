Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0D288C39
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075927; cv=none; b=tJRv21Lgah5GQLTK77IspIl/i4XxtInKvHTRSrbTn6pftud1CGRpPkxgCb1RoO0qZv8jFj+fF/MpFyjsfNYPm5R8UGqVJWqo0nSAu2BXST1UmpYDbMhZRj00rxmyKNQSwLRpkMXf1MG/GDRnzAFQ7PJosJcsBKUCUs3DKsvRplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075927; c=relaxed/simple;
	bh=v3QxbsnYFPFhmHyOT+53OCvrWXMe3iVLPtXS700YHFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Suw+3/FsubmzaVXlvn3b6cKDwmhnmoCO0eyG5cuvpSphH9Wff5u19AIKDInTnr8h27f4eyw50N41LbEjMQiuz9Dq8DgIN3MfHuHeclfq0NYELT3QEBDRlg32fvPbOzqqRjApd/AzA4ibZY4iV7xzIUE4de+3/ETYxbLEiSpQ2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdIfakYe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sav+JHRC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdIfakYe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sav+JHRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770075918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvgXYLhzuo4m8CMvfirt/IQLU1LzuZOJSYGy1TV2tNQ=;
	b=ZdIfakYexuILOEZUcezelP/V2cA+lU4TFNo69ir2XwGFXd5A2fgoVQeiTyFQfpUC817XLE
	NDbD+M72POt2Uytqyxp3UT5HKWNKSYm6lnsEg4AZ/eg27u7gQQx/MInXJ01sJJWzq2TUsQ
	UQURRr4ariFtm4UyFC0VtE9KncA1GKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-kJH5kbX9P6G0O-fBZPuqFg-1; Mon, 02 Feb 2026 18:45:17 -0500
X-MC-Unique: kJH5kbX9P6G0O-fBZPuqFg-1
X-Mimecast-MFC-AGG-ID: kJH5kbX9P6G0O-fBZPuqFg_1770075916
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fe16b481so3419888f8f.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770075916; x=1770680716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lvgXYLhzuo4m8CMvfirt/IQLU1LzuZOJSYGy1TV2tNQ=;
        b=Sav+JHRCO5q+63GngS2OyNbGbAaN4LJ1tzTArNim6Ok5WrSMvHZtznQEJpVS2RerrB
         jJC1eofDv3HC2Ukl4TqHeD5PvnPrTUaRgY4PiuSl2Xh6cQb/Ri1XBQC3J5Ft3lxjN0TQ
         2tMPA4lzi8F1vXVHm6v67688yfcYdRCzya+ZOHHqRTUHVIVy97Nts/f0a6IkrXzZlRCM
         55psjYrasx72o1irMyJcpYAOHMtTH72Bx/E9z4oZhCZ+aEFotmMXa7vUlnXRYchZc4V6
         l9nhqkbGrXS4W/PNU+trBaiwYz8XezVqJSE5a0dBOxRfYyp+0jLTVMVbFJUldKIUNRRF
         ilIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770075916; x=1770680716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvgXYLhzuo4m8CMvfirt/IQLU1LzuZOJSYGy1TV2tNQ=;
        b=c98d9RZuuPm9NXEcgD4sQDeb/rW9TdFtMAOERnCN/A8iG3JkpX6KxRRLNE89o6FHDv
         Wv1uOVCXDe2zA6FpEyFGDvA4qDEfxpkrY51tQuz1jgMKhOu1VdUAdsf5E1qIoQWhGJc2
         VYnv9d6+SncbyZbOBvBfa85Pmu4+Kkpb3aK1MBfvsEoT745nnkA52UKy+u+uxLGy7a+s
         sbs1Ha6MpPKisomP1rOOIh+JSjPnWuTIFZ839YQXk9J749iRr3X8R4oyMpR1e/n7L0xr
         rtm5WZBhBRmmIVUzHWRKQJxWkC8cIgQ9qRgE4COYCcUN9pGdOtmRIfvHeLNWOePzvRCX
         eLLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFnYXIQldIo/HYrRRZPP/z+K6mtO1sL7KzMtpJAsvMWywheNSX5V5SKM7IGeCs7JBWBWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAksS0U/F89CX32AFzih20TSLKDZq02iA05tLHmh4u8xfti1Xx
	MKggwDszT165G9lFtidmD3WGfdxhPb9EfOQt6Th0mFcxvXZqXEMg+Az5N7Miaag/t3Ha9bG3wMr
	najjHd4tF5Dx9yA+1CPKUNL3SHJP+6GN+Y6lyxp109ZCFiObZs15OeA==
X-Gm-Gg: AZuq6aIMqGmoY5vFlwyo8hP3RmLk3q0U711274S3EWr0tbuDt2YhRI6hQ5/qsHbPhUT
	tbZNPj7O+l6Y2GktumbaDTB4sZyLjYg+UI/hS9fV6+PAFonY64rmi7izNuWq4WIeoA54Q5nTbUM
	Qav6PEiNB6WEXwRO+iJ+A5Z0q61PiGAGq8l6BhrTwtg+GsrXRjYD/I/iK+ZixsvHUPjnBtMTsSn
	6LMdk4Zka1OItx+UR1k/WESb95WIbYknx29meoOKB6Erx17FBF/G+QKk6+BNJLOlH2orJsXjuyN
	EGBwHVZ3K/pbbugviKyUjhYrF2JVm9MWHSPk1pZCUXsc/qE/XXTm9GDs0Tirl30mo8T9Zos6TmZ
	fupREpHteqm/THozFIyVWRG3r0TDV6+9Y+Q==
X-Received: by 2002:a05:6000:611:b0:435:e47b:e746 with SMTP id ffacd0b85a97d-435f3aaa5e7mr18354407f8f.36.1770075916010;
        Mon, 02 Feb 2026 15:45:16 -0800 (PST)
X-Received: by 2002:a05:6000:611:b0:435:e47b:e746 with SMTP id ffacd0b85a97d-435f3aaa5e7mr18354364f8f.36.1770075915366;
        Mon, 02 Feb 2026 15:45:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee057sm52844751f8f.15.2026.02.02.15.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 15:45:14 -0800 (PST)
Date: Mon, 2 Feb 2026 18:45:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Message-ID: <20260202184439-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-4-chia-yu.chang@nokia-bell-labs.com>
 <20260201035912-mutt-send-email-mst@kernel.org>
 <AM9PR07MB79696F945D8DBEF370CD4DC6A39AA@AM9PR07MB7969.eurprd07.prod.outlook.com>
 <20260202121830-mutt-send-email-mst@kernel.org>
 <PAXPR07MB7984B37862D3FBBE363AE5A8A39AA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PAXPR07MB7984B37862D3FBBE363AE5A8A39AA@PAXPR07MB7984.eurprd07.prod.outlook.com>

On Mon, Feb 02, 2026 at 09:09:28PM +0000, Chia-Yu Chang (Nokia) wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>=20
> > Sent: Monday, February 2, 2026 6:20 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org; shaojijie@huawei.com=
; shenjian15@huawei.com; salil.mehta@huawei.com; mbloch@nvidia.com; saeedm@=
nvidia.com; leon@kernel.org; eperezma@redhat.com; brett.creeley@amd.com; ja=
sowang@redhat.com; virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.c=
om; pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@vge=
r.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@=
google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.co=
m; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wan=
gcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.=
ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@k=
ernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google=
=2Ecom; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.=
white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@eri=
csson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com;=
 vidhi_goel@apple.com
> > Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in v=
irtio_net_hdr
> >=20
> >=20
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >=20
> >=20
> >=20
> > On Mon, Feb 02, 2026 at 04:56:38PM +0000, Chia-Yu Chang (Nokia) wrote:
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Sunday, February 1, 2026 10:18 AM
> > > > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > > > Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org;=20
> > > > shaojijie@huawei.com; shenjian15@huawei.com; salil.mehta@huawei.com=
;=20
> > > > mbloch@nvidia.com; saeedm@nvidia.com; leon@kernel.org;=20
> > > > eperezma@redhat.com; brett.creeley@amd.com; jasowang@redhat.com;=20
> > > > virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com;=20
> > > > pabeni@redhat.com; edumazet@google.com; parav@nvidia.com;=20
> > > > linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org;=20
> > > > dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org;=20
> > > > netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com;=20
> > > > kuba@kernel.org; stephen@networkplumber.org;=20
> > > > xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net;=20
> > > > andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net;=20
> > > > liuhangbin@gmail.com; shuah@kernel.org;=20
> > > > linux-kselftest@vger.kernel.org; ij@kernel.org;=20
> > > > ncardwell@google.com; Koen De Schepper (Nokia)=20
> > > > <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com;=20
> > > > ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com;=20
> > > > cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com;=20
> > > > vidhi_goel@apple.com
> > > > Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag=
=20
> > > > in virtio_net_hdr
> > > >
> > > >
> > > > CAUTION: This is an external email. Please be very careful when cli=
cking links or opening attachments. See the URL nok.it/ext for additional i=
nformation.
> > > >
> > > >
> > > >
> > > > Thanks for the patch! Yet something to improve:
> > > >
> > > > On Sat, Jan 31, 2026 at 11:55:10PM +0100, chia-yu.chang@nokia-bell-=
labs.com wrote:
> > > > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > > >
> > > > > Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of th=
e=20
> > > > > ACE field to count new packets with CE mark; however, it will be=
=20
> > > > > corrupted by the RFC 3168 ECN-aware TSO. Therefore, fallback shal=
l=20
> > > > > be applied by seting NETIF_F_GSO_ACCECN to ensure that the CWR=20
> > > > > flag should not be changed within a super-skb.
> > > > >
> > > > > To apply the aforementieond new AccECN GSO for virtio, new featue=
=20
> > > > > bits for host and guest are added for feature negotiation between=
=20
> > > > > driver and device. And the translation of Accurate ECN GSO flag=
=20
> > > > > between virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is=
=20
> > > > > also added to avoid CWR flag corruption due to RFC3168 ECN TSO.
> > > > >
> > > > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > >
> > > >
> > > > To the best of my understanding, this is a new feature - support fo=
r VIRTIO_NET_F_HOST_ACCECN, VIRTIO_NET_F_GUEST_ACCECN?
> > > > The commit log makes it sound like it fixes some behaviour for exis=
ting hardware, but that is not the case.
> > > >
> > >
> > > Thansk for the feedback, I will update commit message in v3.
> > > >
> > > > > ---
> > > > > v2:
> > > > > - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS
> > > >
> > > > but where is v2? this is v1...
> > >
> > > I shall update this version as v2, will do at the next version.
> > >
> > > [...]
> > > > > diff --git a/include/uapi/linux/virtio_net.h=20
> > > > > b/include/uapi/linux/virtio_net.h index 1db45b01532b..af5bfe45aa1f
> > > > > 100644
> > > > > --- a/include/uapi/linux/virtio_net.h
> > > > > +++ b/include/uapi/linux/virtio_net.h
> > > > > @@ -56,6 +56,8 @@
> > > > >  #define VIRTIO_NET_F_MQ      22      /* Device supports Receive =
Flow
> > > > >                                        * Steering */
> > > > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address =
*/
> > > > > +#define VIRTIO_NET_F_HOST_ACCECN 25  /* Host can handle GSO of=
=20
> > > > > +AccECN */ #define VIRTIO_NET_F_GUEST_ACCECN 26 /* Guest can=20
> > > > > +handle GSO of AccECN */
> > > > >  #define VIRTIO_NET_F_DEVICE_STATS 50 /* Device can provide=20
> > > > > device-level statistics. */  #define VIRTIO_NET_F_VQ_NOTF_COAL 52=
 /* Device supports virtqueue notification coalescing */
> > > > >  #define VIRTIO_NET_F_NOTF_COAL       53      /* Device supports =
notifications coalescing */
> > > > > @@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {  #define=20
> > > > > VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4=
 | \
> > > > >                                      VIRTIO_NET_HDR_GSO_UDP_TUNNE=
L_IPV6)
> > > > >  #define VIRTIO_NET_HDR_GSO_ECN               0x80    /* TCP has =
ECN set */
> > > > > +#define VIRTIO_NET_HDR_GSO_ACCECN    0x10    /* TCP AccECN segme=
ntation */
> > > > > +#define VIRTIO_NET_HDR_GSO_ECN_FLAGS (VIRTIO_NET_HDR_GSO_ECN | \
> > > > > +                                      VIRTIO_NET_HDR_GSO_ACCECN)
> > > > >       __u8 gso_type;
> > > > >       __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> > > > >       __virtio16 gso_size;    /* Bytes to append to hdr_len per f=
rame */
> > > >
> > > >
> > > > UAPI changes need to be added to the virtio spec.
> > > > Pls get this approved by the virtio TC.
> > > > Thanks!
> > >
> > > There were some discussions last October in virtio-comment@lists.linu=
x.dev mailing list.
> >=20
> >=20
> > That's it I could not find it. Could you include the archive link pls?
>=20
> The email thread I found is https://yhbt.net/lore/all/20250814120118.8178=
7-1-chia-yu.chang@nokia-bell-labs.com/T/#m62dd5e559a68e8d3e5872e85d37c924f6=
5fc7033

or

https://lore.kernel.org/all/20250814120118.81787-1-chia-yu.chang@nokia-bell=
-labs.com/


> There were discussions about updating the documents of SKB_GSO_TCP_ECN an=
d SKB_GSO_TCP_ACCECN, and you can find it in the first patch of this series.

document this in commit log and cover letter pls.

> >=20
> >=20
> > > At that moment, it is suggested to make Linux kernel accept new comme=
nts for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN first.
> > > So, could virtio-spec colleague give your feedback? (Parav?).
> > >
> > > Otherwise, the CWR handling of virtio will be wrong after all Accurat=
e ECN commits are merged in Linux.
> > >
> > > Chia-Yu
> >=20
> > if there's a general agreement we don't need to block linux on tc appro=
val.
> >=20
> > --
> > MST
>=20
> Shall I also submit patches to virtio-spec? Please suggest ways forwards.
>=20
> Thanks!
>=20
> Chia-Yu

