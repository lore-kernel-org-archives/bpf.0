Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C2375F60
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504914; cv=pass; b=tmLlUW6vzAi8fyUh2TxpcQ/ERpdUcmkUVPSMUI7OMm/rVrwOT6V7uoXxGGeOCOgZ0HfGHzFrHXj34MMDncG88FlO0S+mQeLW8u/eJ1kOKMNlyN9PD7VLtdwMHFwUdCnW76OxfiLpNsXEJ7TTAlb1g3Njj+95T5eHirn9h2zlt68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504914; c=relaxed/simple;
	bh=CmpPLTDLjoziZGQueGxnmQI7O2xObKPRhPekUhrY70I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fquL1l8iydZxS0WlT95ypjdY6j57w1rqEvTBAetJfS681YPuKZ1folTj3/MoCkiZg2YA6/rp4oaBOxVpBCpyRZEcactZ9mkBL0rLmT5mfFF3DFi2fHkxgVopg4xXADnfvD3B+tkm671O6K5Yp2nW8wHMiLQYzV51B/8jAZNN2SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EsJG3vBa; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EsJG3vBa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so4571000a91.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 18:28:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772504909; cv=none;
        d=google.com; s=arc-20240605;
        b=MvFkib/5osob97giy0DUoK3+j+tm07lVQMm6jBKqb8a3aqmtRaG/swIrtgT3b+TcT4
         n6dKO7LapWwrwyfFVhlnEXfbMrQI4PTNiQPYWz2C7ZzUITIdGCtVCK/f+cgpfXdGiTUE
         /5yMW/NlPsG0Qemwtln/DfVKXUnOYKj/rBpeMNg6NPbhD+Ld9S4PpQ0mHO3Kf9tJNjGl
         k+DB/vTydMwPmjyEmXXsRzd8o1LcwYWSePV1K1Kv0HSBHzpN4Ix52xU8O1bDgkz090z+
         lpJ7j2hq2g8yUo9DsY0Fief4gyuDHr+Xm4KPYYLYR+11P3lIGNRpv3V1GwUk+ULEBE/G
         npbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1bg6xiI4y6+7k2tjKhPvGRGK3TFDQKnfwBJ+EjIYKA=;
        fh=rv08GqTYWGaP8nxKYv4qPwrShXj1/5mxlko3ZBzCB9Q=;
        b=Rf3Zre75u7q+fu6eKaYobZ/kHuOGsO2zjJC+LoBYKwgAwiR2cWGGtePfWEOhsbLOTk
         IgM/QCyJu2O30CbmGJt1ovRUslv/bIW6rVYa5uTW71NMUqvdL4kI6oLVexAaXsQGedDp
         sBT1ZQ430NNP8NSNNdQzUsE4zLyGumEh9U1An9Gjq5V4ggic5ldzW6j3oC7eqwU6B/17
         +iM2DyVBPXE+rthVInxWoWaxhRy3PYk4eo2y+Q/XVMZoI+gQ+YpOiF1y2Af/dZPZlpan
         Pf2tgPwgLXCGVhFH6njBqKfIOM+QYjZBV1kniEGSHbBNtYschIGYQIrUNhEyz5/Y2hUy
         bbEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772504909; x=1773109709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1bg6xiI4y6+7k2tjKhPvGRGK3TFDQKnfwBJ+EjIYKA=;
        b=EsJG3vBaS1KZW5Izsw4OaIpH7hRkswp/BBxxAkmDxitc8w8FFOEbGPrwFIDKDTkfvb
         el6P57HEQuZcFjAaRfBrYvppssqd1ruzRuX4K9GMbWsv/a+0UdV/wy91N0ItQt8JMY7a
         +fTlI8uCMeBUtsXgkY9VG3mNkYMrQZASXK6Fb2eeSI0EWs+Ecp3RZWF2axg/KRySCujq
         H9Rf6OiWSGLlOnujavHZFxxri5nzMcAFcuYI1rUxw9EWfymRbiJfLVMfJoPIduuGJW6o
         TvrrzCiZ3L0CbmubL55JgO7BYzgGIbyf7FMN2fyQN+DOU1GKA/JOwazVjT7OHeGtXVR4
         LdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772504909; x=1773109709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1bg6xiI4y6+7k2tjKhPvGRGK3TFDQKnfwBJ+EjIYKA=;
        b=iTwEHKCy/IY/s7tX5U93c3TBbMwQZQzvXLTutj7ZM8C5tUN18quPux5suwpZGhvw7p
         tlnLewMOWAWdp3CsArMi1Wvc3By6zUPcq75ZHPwE3xP1SY6jEEHyX8r4XNotM5hnHnRo
         renqDRlLjJc9unnbdh41AQdBD8lbA+DQzlYX+UTI8cLLr//RNrqBOuMsi415eE9tYe75
         iA65r4HlLP2kZypC5rbGz3pcO/8pKQFrNNbW7J0I8n7UtHZWzWgMhmWn/ziSTX3r1Elb
         UvCPLrvSfFaHbt/5JbIrmuh5rggcHbT2RaYZAM8bjh0xq2JdX1XXQU/w7dbvcuAP1iYN
         Rq7g==
X-Forwarded-Encrypted: i=1; AJvYcCXxEL1rLZsuLdD6eRywz7+TbBDOENZiXr40g6thIgkdgp50ooZPT3MjvZfDNkyww6Kcreo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxxvZ3b8AqvhL0TSgEklWN3fB3HrR7+zAFkjVOxPBxa7NnmeAb
	zOrMCzKNkuhHf0GotLRsJzRCzuPWv4QOWqRG8Y49zjUDSd7U/I3OND+klBZWEhVHXN14eGgSTUy
	4I3VSoSKcNEB6sFU/hyP3d/c0K8h0QAYSNRZiQr/U
X-Gm-Gg: ATEYQzzIMEDZcTs4Jtx4T1IwOa8cJCME6TzyFZ7vurUEGwFLCUtSYaknPvapP9goaVk
	Yu27vdB2JhLidro4i0SPciGnR8y1E8yYy+ZNepBdzgnIQoJ6KyBfK4epi7SYOflQTb2QQMlGUCP
	ikPqEfVHIavAu/I/AnjWvd8xy6kNFyRzGAbfjsK7XFCbcFfq3M+w7dhHhKfu4H75IXb/yNfJs50
	3QhggwUcKa26/qBRMxDl5Ol98YxrxkSO31sfQShtpFmzIy/LWR36KwXbyhXTm970RA9SC696mmi
	W1hOCFI=
X-Received: by 2002:a17:90a:7f93:b0:356:1db4:8fe5 with SMTP id
 98e67ed59e1d1-35965cc714fmr9453563a91.29.1772504909127; Mon, 02 Mar 2026
 18:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org> <20260302-iino-u64-v2-49-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-49-e5388800dae0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Mar 2026 21:28:17 -0500
X-Gm-Features: AaiRm53ToDAKLnqMzF7h_Rr5obeE3dnKPI4TQkaY52RSs5vb8oGyabc3Zmeif9I
Message-ID: <CAHC9VhRLAhMYL1ax3+LCeLLhnK0XGnvs0kGPGgHaptTaDynroA@mail.gmail.com>
Subject: Re: [PATCH v2 049/110] security: use PRIino format for i_ino
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 3:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> Convert security i_ino format strings to use the PRIino format
> macro in preparation for the widening of i_ino via kino_t.
>
> Also correct signed format specifiers to unsigned, since inode
> numbers are unsigned values.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/apparmor/apparmorfs.c       |  4 ++--
>  security/integrity/integrity_audit.c |  2 +-
>  security/ipe/audit.c                 |  2 +-
>  security/lsm_audit.c                 | 10 +++++-----
>  security/selinux/hooks.c             | 10 +++++-----
>  security/smack/smack_lsm.c           | 12 ++++++------
>  6 files changed, 20 insertions(+), 20 deletions(-)

No comment on the PRIino specifier, but the LSM framework and SELinux
changes seem complete.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM/SELinux)

--=20
paul-moore.com
