Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2436A37B
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528454; cv=pass; b=IBBa+5ScJsjd4fVzj1Z1NJ4v/TFeQZPvWeMIKmXTVHJ9wP4LkG9YJm1WwhQpno3wJMAc2OqEPjydiQPY3Qx7bzg786DdfdcuVBjmKiQ0cnxcru1/SR7SrlFDuSqXo7wcdhbPvEFshnu1fOsUrtV40QX5h0GLBABVjovpwU8e4tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528454; c=relaxed/simple;
	bh=HaZxmJqYx+9+QhSynH8AmDcWjKIvancPwzCQZQKd8SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3aFDzgLhzB1/lKYO6JzO+2lkfJKP0LjpqWvys8ClMwQ/wze46lkT8N69dH8E6EfsKK+Ab2icQkCVX7B6vZ3LsX6NAhwjalVvyD43/tO+4o2cI/eltKi+fsh+c01nRQSse+3YAOiw9Y9VsrfWp+tsUTsOGbdTYUmjs7DZ1b362M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NPlVNPEd; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NPlVNPEd"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84eb992a881so1360261b3a.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 13:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785528452; cv=none;
        d=google.com; s=arc-20260327;
        b=gHNMapfGj+2aCaN6jzZ5J3+EEbdicXI3ynxoUWKDpJqoi+BaSOfRidG2Z2JUpF8rYt
         4pqbLnXLUi6hSioEim4vNr5W0HFfImTwrzZnNl7HVlFAKvThnFqssyZQoTb5aHp45eku
         Z4tPbgcn8P7Xf2Dme5zN7nIddwobbviWnpIMPkt2fqa9Y3ZU26r4Hhay0d1hjXege2KY
         AzRYEBlYprRIC+KWV4aDZreAG34K25EoXGrKzPunQy+8UNIElpVxsnysdW1vDhHVt/UM
         2ZRjnkGoUy9INd+At827rJFHpKtfHBwLKrh9MAVv3L+lmpNR2glSBchgOGsCz0cj8YhC
         ByqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        fh=mZnTAocp6pY3B8U/xX/O6xf5o4kTowujB9xDhCXtDfA=;
        b=nVbiROtYSXMPoT3t4RmvAg5qc/RlXrYB4l+SiTuwuZ9K2tepWYIvS9RZUJ2XKYlbfW
         zPfVvVWu8UlIhoRdqarvb2/W6d+OEDO69BNfN3oF6/Vc3g4tpd3+8vmoF0a3cnG+leHG
         DIE7eV2Kh0ABb7p1/X/XBE1HugoiJ5whjZuZ0XGwsF68CqKXYgX4PWkq3n2rayouS2ip
         wczmOK2qi6WtFCCXTkYr/oc73SRHPJQh4BBHvsPy1lpU8qJLpli7iZ56rxT1CgLAE6sQ
         eRpBvs8MVEaBGjCVWDdMmt7bm9uuSis25Wwrox3L8xqxL9fiepkndHrrBRMshZvoUMhv
         1aVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785528452; x=1786133252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        b=NPlVNPEdkpYXPJZFPwbxsaV60UpEogskvIjAU9EuMgFV1M1pdX30eUEMpNbcZd94b1
         2gRxZ3L7whZk6DM0OCU5ZE0mVe9F7l1VNH9e5D1dLNE3sapfOKBfrNlY2INCBYhaUU+D
         Qy1Pq0Ja2OghaPhJ5SD2MfpL2GfwXjc6A41eRM7Wh98mjqfHH7/FYowwpjUsLil1FBHa
         hktynS0v4DT82vvLWYbcGZiCfnJ6rBbK4zjySew1QGWe7DAEKDYewlDQqsklNKGmC0T1
         dOLfERsr1Ca8HHki5+fMgF87EdRPhNsNTZ2h2dVCEHY8YScFMiyAoVk66LKpMADwZxDn
         +GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528452; x=1786133252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IINxWFvd1Xd2t87DnvaxuJRBg50D9LzcF6dTbifwyFw=;
        b=LtEqDQu9ML/WpMLtAkpdBZ19XftkR3p0WpKQ7Ic7NDB/3PJFJ4m2+cTwoDOFPEuC6v
         ao1097pTuVxN/UNVb2By7kC3066/KZieBKwB7k0q+jptDTaagpEU62MDF7oybaj4ZrT9
         vTiIFG3tsDU+xyR1K1ZmuR8rWYiHOCYsUNYA4YU3eUwRBBwP2rvmRkfkzPQmsjaOCsAB
         5kLJtAoI1P01IDHDXf+t8nHcdRK8UedryWzBYg7F8D++hA+k9XITg2bjiD9vwv2RbK/k
         D5JhL6YWN4st6Ikou42bFZ/cdCMEr8/Afuo8b42+jqt19+KvPtI6nbHJiivBmp++L5/s
         7AHA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9t1rGsrybLzDcSLU8YowUJmYbBVq7adEXM/Sxbz72CTWj/LgsZXFLgE5ALVJEVDKAnHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbUBnVQXP9yRrmNgIopSVJMNAsHHe6vU+p7X8C4yDTLuUcEq9
	VKQ4bQ5ik4vBCIDUlCdWCwkygXx/2jwieVnOKFhmtiE3UNyXvb4t2pxgfBwPIfYzVDdKHb0mUb9
	+AS5OR05/8PE1vKu5EI6vo6HOxAvgGOs+zLcqwaJn
X-Gm-Gg: AR+sD13G97AsN744oZ2c8/VtAE5JC8WcgFv4o+hxHezaVLB4PXLoGFeRvOY63fiANOX
	910KIqIFj9vMFMbiH5lOMayC5LQk5f6bJRmSBYuSuPCpW7yiKvxEu40aU6fzgSi32R1ChXJQSFD
	Gfs176peJxGZudcZeIhtnigXqfukPSBYkyR073mW+0le9N+XS6WGn2UNdhdPZX8suxoKUwLVm6/
	Y5MkAlIGIGkx0gdHsfMkEN1GHIc3lmHp1C8lJUKA8C4HUqBgdYRxrtrXzvRFFTWeUvx3jcFP1Oe
	usic8hc4vCvAkEEmoNHXad8Tnafjb3RNh5OmDySpaAXqxfDOzsMYUqs=
X-Received: by 2002:a05:6a00:9094:b0:847:7a61:e68e with SMTP id
 d2e1a72fcca58-84ee482cf83mr862916b3a.31.1785528452555; Fri, 31 Jul 2026
 13:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 16:07:20 -0400
X-Gm-Features: AUfX_mwbFUF3u9BOCn6R0bUcxbx1dq-jZz_UTL6QyKSEwU_IdbxDl3CNhAP30WA
Message-ID: <CAHC9VhR8RpkP-N4J0wGbv167NctjFTOg5Z+n4_M0pjp3Fbnamw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> ...

Completely unrelated to everything else in this thread, does anyone
reading this know if Matt Bobrowski is still at Google?  I've been
getting bounces on his @google.com address for a few weeks now, I'm
assuming others have as well?  If anyone is still in touch with Matt,
can you ask him to update his address in MAINTAINERS?  Failing that,
can we at least remove his email from MAINTAINERS (feel free to leave
his name if possible?) so we don't keep getting bounces on postings?

[NOTE: for obvious reasons I dropped Matt's address from this email]

--=20
paul-moore.com
