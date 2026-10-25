Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792890187;
	b=k1O4wK9OomNQtGsFHV/ZHM2ZmQ/t8ECvCGCFgfr2GtFLbMqYb9ZjwHuXBCe9pT/BG3ZQ
	 kOs63HifNiCwiYDE+9z2GhFppIqcnpbQSfGE2CKZD2D+xFGuSdGY4chPpnzWoWWdrJhne
	 VN2KXX/+XqXiJ0XuMyGr9NS5eaD1GiUpupdsegTJgnhpeWIVBOZItYINHdqistMHCJPb7
	 k0c7ZqpoAV6ru6Mi2CdFUTg3nBcdbdJeUIMz+1snAm2oND7OL5x2qK63VGMqEqQwQCNuS
	 FcqJz8cYw3FDNX7LQHOboTXDmgqi25TPr7lGnIjrJTN3wAnR0wU5U/YmUkgEvBGRy+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792890187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=qqgqDYAHzlqXpmIDQatz1//BPsh4olRd/UDmSK8Jpes=;
	b=Eb+n/pSEtQ/y/bm7DvYQkP7vuLipJBPt6n+JYa3nGQGbOW3oltrYCpzUC3vsvUYXvbsb
	 ChGS5x1h/M7BT1l3ABKn9FvuALC5hmhlZki/gPxVXRETousuGZMStKX5nEliqZf5te5lM
	 sWm+k2Eu1yQFSGd5ISIS2EcmfsYdzZ8LfWOzh25hb9daTLlozn1kUDYpVLT4dOCWjsOj7
	 IkS6MhUdR1uciPtslFsk945Qg0IXmMX4zII/evATsArzRwxftHG9o9MvXth4IwVT5/sgq
	 XF2hGJT5/i30ubsPT4oD1gStJYwkM50KMVOU81Kmg+Qkwpgdh8A84/9U35lzDU/z2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CMX8+IA3;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C7606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 01:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CMX8+IA3
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e987b4a710so15407345ad.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792890186; x=1793494986; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qqgqDYAHzlqXpmIDQatz1//BPsh4olRd/UDmSK8Jpes=;
        b=CMX8+IA3PHnbaPXDS7SeiYY+f/KrmlN9thkeiaU6JbkpdmgsEdSpjrxwP8MvcVbWj2
         VO2M6duUMEaoihgMlgBcfYbVc/JZb2e2wdBDDE258DK4lpkYDP0sAPgdK9RsL9gXFih2
         k0a7KzGE+l/DJfPZs/d42WsO+df6k2IOYDb7TTiHIsIRXhLWiQxQUsbvj3T6+rFZ7vlI
         jQm/LN3PUWgI8tuT809aGjdQbIwSe/s7tYqxLbZevJ9dxE2QFVFPd9MCmePX+jPnQ8wQ
         fkWO62HJbYG9UInIuAIN1Fw9fEcnda4nsyl5eveWyVZdRAotEf9zRgdXOn8i3X2fhqy2
         9Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792890186; x=1793494986;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqgqDYAHzlqXpmIDQatz1//BPsh4olRd/UDmSK8Jpes=;
        b=LVry6hS4IEER0QrysHnfsvBvSJxC8aZa93QkrDKAcw5SKZ7XyxVvSvrIHcXCIUHQQp
         EhpB1ws3o4I5ayxLeJBSLkAuuK/qXgK7InbLamBbiKWplHxAIodNLOxbgCAmJXxlg5qL
         yM6M8hfV+kU1XUjcCP+CT1s68mRPVfl7YBkmPi7xTn/S2CWGDXNp3rfniA0Ov/WlBZi+
         JVZDCBwYZihXh8CwrkOJ1OC8De6WkBpUzkZtGL4Jn5tTHpYzupJNCTtpycUk5tTVkbim
         OdVdf0Y1NV1B3kDeJy8vXVogJDscLvOXpbjdAo6CxmUsGzB+Gt/Cw9SBLL54SLkqyGtj
         kgJw==
X-Forwarded-Encrypted: i=1; AKwUvByuYBUrFryJxxlbX0GHvl0pRdjzZs55alaKwJBdVzUpa6CSPpVKx+NtTtDVfxoPwS1EdDg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv90QwDA6TThJnSPaRToFtZ6oiWnmaJzUHD6dGQ66BttyflD+Q
	YtqE6FZBC+Df8RuPH4jLYT32aKsuaLms7rodexC21lh/Rpx0TF5n+Z0R
X-Gm-Gg: AYBFou3yN7DKFGNXpy70Ks4JMIpYztR/gQ5KdALlDNJ/4dSLWOSkavcWFJkDg8rAMto
	gcpxyirEkEEuVaWlKnOJGUW6Btx5LyxtSr+jXBigxhYkAeL21uYk3hhHtAEluGBGYKIsvJAbtwN
	ByOtK/yfbLUVOAt7kr6qc0QY2rEgUm6F1YO36k7PzNWzhtis0SGkiZtu0gRgiNkAphpnBpe/WHN
	X3g17S1h/f4X2if0ASymsHm81xMtr0gjedJBZ5lxVjy5JtGNB7GDKUYU6uGuElg5Ikvq1kBaaZ0
	+bfUXBfS4tzH+HaQst6P9ACrbLkJRGoo+y25YNGSaUm2DddQPS+dJzdbes6mq/5ilawWDS8Zuyk
	ca1ncDH7MxqOQ9JW8hpYbg8U1mU3ejhhkMhaQpbXbuOJox0EJVxF93J+4hZ/PkZ6zmJFHE0HOcJ
	3qfhMZminwIPhzcqFXornjrdp0FtiFbxpT0HNCA4bvXEXThwcmc7yDFBLB+NOY6NB/k1WTXlC2X
	CNxt5JLaXwCTWe2VaiW6IRSCk55hShYFLWOXcMHiwUXJ6YduU8pa3sOK/vV4jUQeHSVneg1GqRE
	E078BRVFVMEATgws28ykkkpHow6K/0T5pGW6jav+urWO3hZUmwY6B6NS5XDSIhtoGevuuy6bCNl
	twzbavg==
X-Received: by 2002:a17:90b:518d:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3adeb5511cdmr1755632a91.9.1792890186132;
        Sat, 24 Oct 2026 18:03:06 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca7casm4108035a91.4.2026.10.24.18.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 18:03:05 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 01:03:05 +0000
Message-Id: <DMDIJ0LUPMZX.3B6KY51D9ZRB1@gmail.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <martin.lau@kernel.org>, <mason@kernel.org>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 02/11] bpf: do not intersect with current
 register range on clamp
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bot+bpf-ci@kernel.org>,
 <bpf@vger.kernel.org>, <ast@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261023-scev-simpler-clamp-v1-2-d43a07eda7af@gmail.com>
 <8443794e24eae423d0f499a1d2f24576aa5bb70f6e5f6e015914cb0d1a72210a@mail.kernel.org> <4656dc2d7b8749adb9c9b26490a3ef37aea58715.camel@gmail.com>
In-Reply-To: <4656dc2d7b8749adb9c9b26490a3ef37aea58715.camel@gmail.com>

On Sat Oct 24, 2026 at 6:57 AM UTC, Eduard Zingerman wrote:
> On Sat, 2026-10-24 at 00:41 +0000, bot+bpf-ci@kernel.org wrote:
>
> ...
>
>> Since bisection can land on this commit, could that change be folded int=
o
>> this patch or ordered before it?
>
> Commits should remain separate for documentation purposes.
> Full test suite passes on both.
>
>> A related question about the end of the series.=C2=A0 cf18840bc068 only =
helps
>> when the current frame has no active loop.=C2=A0 Consider states inside =
an inner
>> loop that is entered again on the second iteration of a terminating oute=
r
>> loop.=C2=A0 current_loop() finds the inner loop in both states, but its
>> entry_state differs, because handle_loop_entry_exit() splits a new one o=
n
>> each entry.=C2=A0 So the EXACT check runs, and loop_stack_safe() does no=
t
>> compare entry_state.
>>=20
>> With the outer induction variable now the same on every outer iteration,=
 a
>> program like the one below looks like it would still hit "infinite loop
>> detected" after cf18840bc068 (with the old code the outer induction
>> variable was [1..9] on the second outer iteration and the EXACT compare
>> failed):
>>=20
>> =C2=A0=C2=A0=C2=A0 w1 =3D 1;
>> =C2=A0=C2=A0=C2=A0 *(u32 *)(r10 - 8) =3D r1;
>> =C2=A0=C2=A0=C2=A0 r6 =3D 0;
>> 1:=C2=A0 r7 =3D 0;
>> 2:=C2=A0 *(u32 *)(r10 - 4) =3D 1;=C2=A0=C2=A0 /* fp-8 spill -> STACK_MIS=
C */
>> =C2=A0=C2=A0=C2=A0 r7 +=3D 1;
>> =C2=A0=C2=A0=C2=A0 if r7 < 3 goto 2b;
>> =C2=A0=C2=A0=C2=A0 r6 +=3D 1;
>> =C2=A0=C2=A0=C2=A0 if r6 < 10 goto 1b;
>> =C2=A0=C2=A0=C2=A0 r0 =3D *(u32 *)(r10 - 8);
>> =C2=A0=C2=A0=C2=A0 exit;
>>=20
>> Is that case covered somewhere I missed?
>
> This example is valid. Need to relax the condition in the
> current_loop() or bpf_is_state_visited().

so you're going to respin it or follow up?

It's fine to ignore CI in patch 3.
We'll be removing states.c soon.
